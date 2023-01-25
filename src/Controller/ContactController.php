<?php

namespace App\Controller;

use App\Form\ContactType;
use Symfony\Bridge\Twig\Mime\TemplatedEmail;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\Mime\Address;
use Symfony\Component\String\Slugger\SluggerInterface;

class ContactController extends AbstractController
{
    #[Route('/contact', name: 'contact')]
    public function index(Request $request, MailerInterface $mailer, SluggerInterface $slugger): Response
    {
        $form = $this->createForm(ContactType::class);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            // pot de miel
            if (empty($form['honeypot']->getData())) { //si le pot de miel est vide, je fais le traitement
                $contact = $form->getData(); // récupère les informations du formulaires
                $email = (new TemplatedEmail()) // prépare un email sur la base d'un template
                    ->from(new Address($contact['email'], $contact['first_name'] . ' ' . $contact['last_name'])) // expéditeur
                    ->to(new Address('gregoire.constant.gc@gmail.com', 'Grégoire CONSTANT')) // destinataire
                    ->replyTo(new Address($contact['email'], $contact['first_name'] . ' ' . $contact['last_name'])) // adresse pour la réponse
                    ->htmlTemplate('email/contact.html.twig') // chemin du template
                    ->context([ // passe les informations du formulaire au template
                        'firstName' => $contact['first_name'],
                        'lastName' => $contact['last_name'],
                        'company' => $contact['company'],
                        'emailAddress' => $contact['email'],
                        'subject' => $contact['subject'],
                        'message' => $contact['message']
                    ]) 
                ;
                if ($contact['attachment'] !== null) { // vérifie s'il y a un fichier dans le formulaire
                    $originalFileName = pathinfo($contact['attachment']->getClientOriginalName(), PATHINFO_FILENAME); // récupère le nom original du fichier
                    $saveFileName = $slugger->slug($originalFileName);// slug
                    $newFileName = $saveFileName . '.' . $contact['attachment']->guessExtension();  // renommer le fichier
                    $email->attachFromPath($contact['attachment']->getPathName(), $newFileName); // renommer la pièce-jointe
                }
                $mailer->send($email);
                $this->addFlash('success', 'Votre message a bien été envoyé. Nous vous répondrons dans les plus brefs délai');
                return $this->redirectToRoute('contact');
            } else {
                $this->addFlash('danger', 'Ne seriez-vous pas un robot ?');
                return $this->redirectToRoute('app_home');
            }

            // envoie de mail

            // message de succès

            // redirection
        }

        return $this->render('contact/index.html.twig', [
            'contactForm' => $form->createView()
        ]);
    }
}
