# DevOps Challenge

[[_TOC_]]

## Práctico

### Terraform:

Crear un cluster en kubernetes para deployar. Considera usar el provider de aws y un state remoto.

### Kubernetes

Usando Helmfile crea un multistage deployment. Con los siguientes comandos deberiamos poder deployar la misma imagen, con diferentes configuraciones al mismo cluster:

- `helmfile -e dev apply`
- `helmfile -e stage apply`

La imagen a utilizar es: [nginx](​https://hub.docker.com/r/nginxdemos/hello/)

Se debe modificar la imagen para agregar lo siguiente:

- Environment: dev, stage
- Secret (Usar helm-secrets o sealed-secrets)

Crear un diagrama de arquitectura.

### Pipeline

Prepara un pipeline que genere la imagen y puedas deployar una nueva version de forma automatica.
Este pipeline deberia tener todos los stages recomendados. No es necesario crear los tests, pero si especificarlos en el pipeline.

## Teórico

### Terraform

1. Explica con tus palabras que son los modulos de terraform.
   **Componente reutilizable del lenguaje**
2. Como probarias un modulo de terraform, como te aseguras de que el modulo esta correcto?
   **Utilitario tfsec, terraform plan**

---

### Docker

1. Que son las capas?
   **Snapshots inmutables de la imagen (SO)**
2. Como puedo dejar la imagen lo mas ligera posible?
   **Reducir el numero de lineas de codigo en el Dockerfile**

### Kubernetes

1. Como puedo modificar el puerto de un pod que esta corriendo?
   **Modificar el puerto del servicio que balancea el trafico, ya que no se puede modificar el puerto del pod corriendo**
2. Como actualizarias la version del cluster y que deberia considerar?
   **Resumiendo: Debe ser paulatinamente drenandolos y realizar primero los master luego los worker; considerar solo subir una version a la vez (eg. 1.22 -> 1.23)**

### AWS

1. Como puedo acceder desde una cuenta A, recursos de una cuenta B?
   **Se debe crear un IAM Rol**
2. Como harias para manejar multiples recursos desde una sola cuenta?, ejemplo: identity account -> environments account y shared services account.
   **Crear un grupo en IAM asignar las policies de acceso a los recursos y añadir al usuario en el grupo creado**

### CI/CD

1. Dibuja un diagrama con vision de pipeline ideal
2. Nombra 3 antipatrones DevOps
3. Nombra 2 branching strategies
   **Gitflow, Github flow**
4. Que es Continuous Integration, Continuous Delivery y Continuous Deployment
