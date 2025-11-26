#!/bin/bash

# Script de Instalação Automatizada do n8n
# Para Ubuntu 22 LTS
# Autor: Manus AI Assistant

set -e

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  Instalador Automatizado do n8n${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

# Verificar se está rodando como root ou com sudo
if [ "$EUID" -ne 0 ]; then 
    echo -e "${RED}Por favor, execute este script com sudo:${NC}"
    echo "sudo bash install-n8n.sh"
    exit 1
fi

# Atualizar sistema
echo -e "${YELLOW}[1/7] Atualizando sistema...${NC}"
apt update -y
apt upgrade -y

# Instalar dependências básicas
echo -e "${YELLOW}[2/7] Instalando dependências básicas...${NC}"
apt install -y curl wget git build-essential

# Instalar Node.js (versão LTS via NodeSource)
echo -e "${YELLOW}[3/7] Instalando Node.js 20 LTS...${NC}"
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt install -y nodejs

# Verificar instalação do Node.js
echo -e "${GREEN}Node.js instalado: $(node --version)${NC}"
echo -e "${GREEN}npm instalado: $(npm --version)${NC}"

# Instalar n8n globalmente
echo -e "${YELLOW}[4/7] Instalando n8n...${NC}"
npm install -g n8n

# Instalar PM2 para gerenciar o processo
echo -e "${YELLOW}[5/7] Instalando PM2...${NC}"
npm install -g pm2

# Criar diretório para dados do n8n
echo -e "${YELLOW}[6/7] Configurando diretórios...${NC}"
mkdir -p /home/n8n/.n8n
chown -R $SUDO_USER:$SUDO_USER /home/n8n 2>/dev/null || true

# Criar arquivo de configuração do PM2
echo -e "${YELLOW}[7/7] Configurando n8n como serviço...${NC}"

cat > /tmp/n8n-pm2.json <<EOF
{
  "apps": [{
    "name": "n8n",
    "script": "n8n",
    "cwd": "/home/n8n",
    "instances": 1,
    "autorestart": true,
    "watch": false,
    "max_memory_restart": "1G",
    "env": {
      "N8N_BASIC_AUTH_ACTIVE": "true",
      "N8N_BASIC_AUTH_USER": "admin",
      "N8N_BASIC_AUTH_PASSWORD": "admin123",
      "N8N_HOST": "0.0.0.0",
      "N8N_PORT": "5678",
      "N8N_PROTOCOL": "http",
      "WEBHOOK_URL": "http://$(curl -s ifconfig.me):5678/",
      "GENERIC_TIMEZONE": "America/Sao_Paulo"
    }
  }]
}
EOF

# Iniciar n8n com PM2
pm2 delete n8n 2>/dev/null || true
pm2 start /tmp/n8n-pm2.json
pm2 save
pm2 startup systemd -u root --hp /root

# Configurar firewall (se UFW estiver ativo)
if command -v ufw &> /dev/null; then
    echo -e "${YELLOW}Configurando firewall...${NC}"
    ufw allow 5678/tcp
    ufw --force enable
fi

# Obter IP público
PUBLIC_IP=$(curl -s ifconfig.me)

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  ✓ Instalação Concluída com Sucesso!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo -e "${YELLOW}Informações de Acesso:${NC}"
echo -e "URL: ${GREEN}http://${PUBLIC_IP}:5678${NC}"
echo -e "Usuário: ${GREEN}admin${NC}"
echo -e "Senha: ${GREEN}admin123${NC}"
echo ""
echo -e "${YELLOW}Comandos Úteis:${NC}"
echo "  pm2 status          - Ver status do n8n"
echo "  pm2 logs n8n        - Ver logs do n8n"
echo "  pm2 restart n8n     - Reiniciar n8n"
echo "  pm2 stop n8n        - Parar n8n"
echo "  pm2 start n8n       - Iniciar n8n"
echo ""
echo -e "${RED}IMPORTANTE: Altere a senha padrão após o primeiro login!${NC}"
echo ""
