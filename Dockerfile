# Dockerfile
FROM ubuntu:latest

# Mettre à jour les paquets et installer les dépendances nécessaires
RUN apt-get update && \
    apt-get install -y curl gnupg software-properties-common openssh-server wget && \
    mkdir /var/run/sshd && \
    echo 'root:vagrant' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    service ssh restart

# Configuration du dépôt HashiCorp et installation de Terraform
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && \
    apt-get install terraform -y

# Exposer le port SSH
EXPOSE 22

# Commande par défaut pour garder le conteneur en vie
CMD ["sh", "-c", "while true; do sleep 1000; done"]
