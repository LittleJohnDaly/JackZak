<?php

namespace App\Controller;

use App\Repository\BlogRepository;
use App\Repository\ProductRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class HomeController extends AbstractController
{
    #[Route('/', name: 'app_home')]
    public function index(ProductRepository $productRepository, BlogRepository $blogRepository): Response
    {
        return $this->render('home/index.html.twig', [
            // 'products' => $productRepository->findAll() // récupère tous les produits
            'products' => $productRepository->findBy([ 'id' => [52,51] ], ['created_at' => 'DESC', 'id' => 'DESC']), // récupère 4 produits triés par date d'ajout décroissante
            'blogs' => $blogRepository->findBy([], ['created_at' => 'DESC', 'id' => 'DESC'], 1)
            // 'products' => $productRepository->findLast(4) // queryBuilder
            // 'products' => $productRepository->findLastFour() // SQL
        ]);
    }

}
