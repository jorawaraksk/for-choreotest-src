FROM python:3.9

WORKDIR /app

COPY requirements.txt /app/

RUN pip3 install --no-cache-dir -r requirements.txt

COPY . /app

# 🔐 Add a non-root user with a UID between 10000–20000
RUN useradd -u 10001 -m appuser && chown -R 10001 /app

# ✅ Use UID directly as required by Choreo
USER 10001

EXPOSE 3000

CMD flask run -h 0.0.0.0 -p 3000 & python3 main.py
