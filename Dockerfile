# Utiliser l'image Python officielle
FROM python:3.12-alpine

# Copier le fichier app.py dans le conteneur
COPY app.py /app.py

# Définir la commande à exécuter quand le conteneur démarre
CMD ["python", "/app.py"]
