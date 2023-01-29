<?php

namespace App\Controller;

use App\Entity\Blog;
use App\Form\BlogType;
use App\Repository\BlogRepository;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\String\Slugger\SluggerInterface;

class BlogController extends AbstractController
{
    private $managerRegistry;
    private $blogRepository;

    public function __construct(ManagerRegistry $managerRegistry, BlogRepository $blogRepository)
    {
        $this->managerRegistry = $managerRegistry;
        $this->blogRepository = $blogRepository;
    }

    #[Route('/blogs', name: 'blogs')]
    public function index(BlogRepository $blogRepository): Response
    {
        return $this->render('blog/index.html.twig', [
            'blogs' => $blogRepository->findBy([], ['id' => 'DESC'])
        ]);
    }

    #[Route('/admin/blogs', name: 'admin_blogs')]
    public function adminIndex(): Response
    {
        return $this->render('blog/adminList.html.twig', [
            'blogs' => $this->blogRepository->findAll()
        ]);
    }

    #[Route('/admin/blog/create', name: 'blog_create')]
    public function create(Request $request, SluggerInterface $slugger): Response
    {
        $blog = new Blog();
        $form = $this->createForm(BlogType::class, $blog);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {

            $infoImg1 = $form['img']->getData();

            if (empty($infoImg1)) {
                $this->addFlash('danger', 'Le produit n\'a pas pu être créé : l\'image principale est obligatoire mais n\'a pas été renseignée.');
                return $this->redirectToRoute('blog_create');
            } elseif (empty($form['alt']->getData())) {
                $this->addFlash('danger', 'Le texte alternatif pour l\'image pricnipale est obligatoire.');
                return $this->redirectToRoute('blog_create');
            }

            $img1Name = time() . '-1.' . $infoImg1->guessExtension();
            $infoImg1->move($this->getParameter('blog_img_dir'), $img1Name);
            $blog->setImg($img1Name);

            $blog->setSlug(strtolower($slugger->slug($blog->getTitle())));
            $blog->setCreatedAt(new \DateTimeImmutable());

            $manager = $this->managerRegistry->getManager();
            $manager->persist($blog);
            $manager->flush();

            $this->addFlash('success', 'L\'article a bien été créé');
            return $this->redirectToRoute('admin_blogs');
        }

        return $this->render('blog/form.html.twig', [
            'blogForm' => $form->createView()
        ]);
    }

    #[Route('/admin/blog/update/{id}', name: 'blog_update')]
    public function update(blog $blog, Request $request, SluggerInterface $slugger): Response
    {
        $form = $this->createForm(blogType::class, $blog);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {

            $img1Info = $form['img']->getData(); // récupère les informations de l'image 1 dans le formulaire
            if ($img1Info !== null) { // s'il y a bien une image dans le formulaire
                $oldImg1Path = $this->getParameter('blog_img_dir') . '/' . $blog->getImg(); // récupère le nom de l'ancienne image
                if (file_exists($oldImg1Path)) {
                    unlink($oldImg1Path); // supprime l'ancienne image
                }
                $newImg1Name = time() . '-1.' . $img1Info->guessExtension(); // crée un nom de fichier unique pour l'image 1
                $img1Info->move($this->getParameter('blog_img_dir'), $newImg1Name); // télécharge le fichier dans le dossier adéquat
                $blog->setImg($newImg1Name); // définit le nom de l'image à mettre en base de données
            }

            $blog->setSlug(strtolower($slugger->slug($blog->getTitle())));
            $manager = $this->managerRegistry->getManager();
            $manager->persist($blog);
            $manager->flush();

            $this->addFlash('success', 'Le produit a bien été modifié');
            return $this->redirectToRoute('admin_blogs');
        }

        return $this->render('blog/form.html.twig', [
            'blogForm' => $form->createView()
        ]);
    }

    #[Route('/admin/blog/delete/{id}', name: 'blog_delete')]
    public function delete(blog $blog): Response
    {
        $img1path = $this->getParameter('blog_img_dir') . '/' . $blog->getImg();
        if (file_exists($img1path)) {
            unlink($img1path);
        }

        $manager = $this->managerRegistry->getManager();
        $manager->remove($blog);
        $manager->flush();

        $this->addFlash('success', 'Le produit a bien été supprimé');
        return $this->redirectToRoute('admin_blogs');
    }

}
