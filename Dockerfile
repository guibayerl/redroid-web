# Usa uma base leve com Node.js
FROM node:18-bullseye-slim

# Instala ferramentas do sistema necessárias (ADB e Git)
RUN apt-get update && apt-get install -y \
    android-tools-adb \
    git \
    python3 \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Cria a pasta de trabalho
WORKDIR /app

# Copia os arquivos do projeto (como não tens os arquivos no repo ainda, vamos clonar o original aqui dentro)
# Esta é uma manobra de "Build" para garantir que pegamos o código mais recente da NetrisTV
RUN git clone https://github.com/NetrisTV/ws-scrcpy.git .

# Instala as dependências do projeto
RUN npm install

# Copia e compila o código
RUN npm run dist

# Expõe a porta do site
EXPOSE 8000

# Comando para iniciar
CMD ["npm", "start"]
