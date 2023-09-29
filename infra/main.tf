terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

# Définition de la ressource pour construire l'image Docker
resource "docker_image" "firstfapi_image" {
  name          = "firstfapi_image"  # Le nom de l'image Docker
  build {
    context    = ".."  # Utilisez la racine du projet comme contexte
    dockerfile = "./Dockerfile"  # Le chemin vers le Dockerfile à la racine du projet
  }
}

# Définition de la ressource pour le conteneur Docker
resource "docker_container" "firstfapi_container" {
  name  = "firstfapi_container"  # Le nom du conteneur Docker
  image = docker_image.firstfapi_image.image_id  # Utilise l'image Docker précédemment construite

  # Définition des ports exposés dans le conteneur Docker
  ports {
    internal = 80  # Port interne du conteneur Docker
    external = 8080  # Port externe de la machine hôte
  }

}
