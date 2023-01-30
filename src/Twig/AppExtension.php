<?php

namespace App\Twig;

use App\Repository\ProductRepository;
use Twig\Extension\AbstractExtension;
use Twig\TwigFunction;

class AppExtension extends AbstractExtension
{
    private $productRepository;

    /**
     * @param $productRepository
     */
    public function __construct(ProductRepository $productRepository)
    {
        $this->productRepository = $productRepository;
    }

    public function getFunctions(): array
    {
        return [
            new TwigFunction('get_livres', [$this, 'getLivres']),
        ];
    }

    public function getLivres()
    {
        return $this->productRepository->findBy([], ['id' => 'DESC']);
    }
}