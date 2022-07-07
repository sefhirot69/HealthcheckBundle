<?php

declare(strict_types=1);

namespace Theater\Shared\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;

final class HealthController extends AbstractController
{

    public function __invoke() : JsonResponse
    {
        return new JsonResponse(['status' => 'ok'], Response::HTTP_OK);
    }
}