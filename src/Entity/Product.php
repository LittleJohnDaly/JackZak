<?php

namespace App\Entity;

use App\Repository\ProductRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: ProductRepository::class)]
class Product
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 100)]
    private ?string $title = null;

    #[ORM\Column(length: 100)]
    private ?string $slug = null;

    #[ORM\Column(length: 255)]
    private ?string $abstract = null;

    #[ORM\Column(type: Types::TEXT)]
    private ?string $description = null;

    #[ORM\Column]
    private ?int $quantity = null;

    #[ORM\Column]
    private ?float $price = null;

    #[ORM\Column(length: 45)]
    private ?string $author = null;

    #[ORM\Column]
    private ?\DateTimeImmutable $created_at = null;

    #[ORM\ManyToOne(inversedBy: 'products')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Category $category = null;

    #[ORM\Column(length: 45)]
    private ?string $img1 = null;

    #[ORM\Column(length: 255)]
    private ?string $alt1 = null;

    #[ORM\Column(length: 45, nullable: true)]
    private ?string $img2 = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $alt2 = null;

    #[ORM\Column(length: 45, nullable: true)]
    private ?string $img3 = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $alt3 = null;

    #[ORM\OneToMany(mappedBy: 'product', targetEntity: OrderHasProduct::class)]
    private Collection $orderHasProducts;

    #[ORM\Column]
    private ?int $pages = null;

    public function __construct()
    {
        $this->orderHasProducts = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getTitle(): ?string
    {
        return $this->title;
    }

    public function setTitle(string $title): self
    {
        $this->title = $title;

        return $this;
    }

    public function getSlug(): ?string
    {
        return $this->slug;
    }

    public function setSlug(string $slug): self
    {
        $this->slug = $slug;

        return $this;
    }

    public function getAbstract(): ?string
    {
        return $this->abstract;
    }

    public function setAbstract(string $abstract): self
    {
        $this->abstract = $abstract;

        return $this;
    }

    public function getDescription(): ?string
    {
        return $this->description;
    }

    public function setDescription(string $description): self
    {
        $this->description = $description;

        return $this;
    }

    public function getQuantity(): ?int
    {
        return $this->quantity;
    }

    public function setQuantity(int $quantity): self
    {
        $this->quantity = $quantity;

        return $this;
    }

    public function getPrice(): ?float
    {
        return $this->price;
    }

    public function setPrice(float $price): self
    {
        $this->price = $price;

        return $this;
    }


    public function getAuthor(): ?string
    {
        return $this->author;
    }

    public function setAuthor(?string $author): self
    {
        $this->author = $author;

        return $this;
    }

    public function getCreatedAt(): ?\DateTimeImmutable
    {
        return $this->created_at;
    }

    public function setCreatedAt(\DateTimeImmutable $created_at): self
    {
        $this->created_at = $created_at;

        return $this;
    }

    public function getCategory(): ?Category
    {
        return $this->category;
    }

    public function setCategory(?Category $category): self
    {
        $this->category = $category;

        return $this;
    }

    public function getImg1(): ?string
    {
        return $this->img1;
    }

    public function setImg1(string $img1): self
    {
        $this->img1 = $img1;

        return $this;
    }

    public function getAlt1(): ?string
    {
        return $this->alt1;
    }

    public function setAlt1(string $alt1): self
    {
        $this->alt1 = $alt1;

        return $this;
    }

    public function getImg2(): ?string
    {
        return $this->img2;
    }

    public function setImg2(string $img2): self
    {
        $this->img2 = $img2;

        return $this;
    }

    public function getAlt2(): ?string
    {
        return $this->alt2;
    }

    public function setAlt2(?string $alt2): self
    {
        $this->alt2 = $alt2;

        return $this;
    }

    public function getImg3(): ?string
    {
        return $this->img3;
    }

    public function setImg3(?string $img3): self
    {
        $this->img3 = $img3;

        return $this;
    }

    public function getAlt3(): ?string
    {
        return $this->alt3;
    }

    public function setAlt3(?string $alt3): self
    {
        $this->alt3 = $alt3;

        return $this;
    }

    /**
     * @return Collection<int, OrderHasProduct>
     */
    public function getOrderHasProducts(): Collection
    {
        return $this->orderHasProducts;
    }

    public function addOrderHasProduct(OrderHasProduct $orderHasProduct): self
    {
        if (!$this->orderHasProducts->contains($orderHasProduct)) {
            $this->orderHasProducts->add($orderHasProduct);
            $orderHasProduct->setProduct($this);
        }

        return $this;
    }

    public function removeOrderHasProduct(OrderHasProduct $orderHasProduct): self
    {
        if ($this->orderHasProducts->removeElement($orderHasProduct)) {
            // set the owning side to null (unless already changed)
            if ($orderHasProduct->getProduct() === $this) {
                $orderHasProduct->setProduct(null);
            }
        }

        return $this;
    }

    public function getPages(): ?int
    {
        return $this->pages;
    }

    public function setPages(int $pages): self
    {
        $this->pages = $pages;

        return $this;
    }
}
