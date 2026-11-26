# Builds LexiVoice Studio from studio.zip, so the repo only needs three files.
FROM python:3.12-slim

WORKDIR /app

COPY studio.zip /app/studio.zip
RUN python -c "import zipfile; zipfile.ZipFile('/app/studio.zip').extractall('/app')" \
 && rm /app/studio.zip

RUN pip install --no-cache-dir -r /app/requirements.txt

# Render injects PORT; the app reads it (LEXIVOICE_PORT wins if set).
ENV LEXIVOICE_HOST=0.0.0.0 \
    LEXIVOICE_MAX_JOBS=1 \
    PYTHONUNBUFFERED=1

EXPOSE 8000
CMD ["python", "-m", "app"]
