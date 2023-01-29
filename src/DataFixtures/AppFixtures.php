<?php

namespace App\DataFixtures;

use App\Entity\Category;
use App\Entity\Product;
use Doctrine\Persistence\ObjectManager;
use Doctrine\Bundle\FixturesBundle\Fixture;

class AppFixtures extends Fixture
{
    public function load(ObjectManager $manager): void
    {
        $category1 = new Category();
        $category1
            ->setName('Stratégie')
            ->setSlug('strategie')
            ->setDescription(null);
        $manager->persist($category1);

        for ($i = 0; $i < 50; $i++) {
            $product1 = new Product();
            $product1
                ->setTitle('Sur les ailles d\'un papillon')
                ->setSlug('sur-les-ailles-d-un-papillon')
                ->setQuantity(19)
                ->setAbstract('')
                ->setDescription('La vie peut être un terrible fardeau pour Florent, ce jeune papa divorcé aux prises avec ses démons intérieurs. Alcoolique, mélancolique et instable, il observe son monde s’effondrer un peu plus chaque jour. S’il ne pouvait pas s’accrocher à l’amour qu’il porte pour son chien, sa petite fille et la bouteille, il le sait, il ne serait déjà plus de ce monde.
                Alors qu’il se bat violemment pour retrouver le goût de vivre, pour retrouver un sens à sa sombre existence, le bonheur finit par frapper à sa porte. Mais malgré tous ses efforts, son passé n’est jamais loin, semant sans pudeur les cadavres qu’il tente d’enfouir.
                Ce livre vous immergera dans les limbes du cerveau torturé de Florent où vous rencontrerez la folie à l’état brut, mais aussi « L’ombre », cette ignoble ombre qui habite dans les entrailles de chaque Homme et qui prend un malin plaisir à nous pousser au bord du précipice.
                Paranoïa ? Personne malintentionnée ? Délire d’un homme brisé qui lutte vainement ? Qui ou qu’est ce qui se cache derrière tous ses malheurs ? Il le pense, il le sait, ou pense le savoir ! On essaie de le détruire. Mais pourquoi ?')
                ->setPrice(18.50)
                ->setCategory($category1)
                ->setPages(538)
                ->setImg1('1674742455-1.jpg')
                ->setImg2('')
                ->setImg3('')
                ->setAlt1('image de couverture du livre')
                ->setAlt2('')
                ->setAlt3('')
                ->setAuthor('JackZak')
                ->setCreatedAt(new \DateTimeImmutable());
            $manager->persist($product1);
        }

        $manager->flush();
    }
}
