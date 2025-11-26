#!/bin/bash

# Script para Configurar n8n em Português Brasil
# Define o idioma padrão como pt-BR

set -e

# Cores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  Configurando n8n em Português Brasil${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

# Parar n8n
echo -e "${YELLOW}[1/3] Parando n8n...${NC}"
pm2 stop n8n

# Atualizar configuração
echo -e "${YELLOW}[2/3] Atualizando configuração de idioma...${NC}"

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
      "N8N_SECURE_COOKIE": "false",
      "N8N_DEFAULT_LOCALE": "pt-BR",
      "WEBHOOK_URL": "http://$(curl -s ifconfig.me):5678/",
      "GENERIC_TIMEZONE": "America/Sao_Paulo"
    }
  }]
}
EOF

# Reiniciar n8n
echo -e "${YELLOW}[3/3] Reiniciando n8n...${NC}"
pm2 delete n8n
pm2 start /tmp/n8n-pm2.json
pm2 save

# Obter IP público
PUBLIC_IP=$(curl -s ifconfig.me)

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  ✓ Idioma Configurado com Sucesso!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo -e "${YELLOW}Acesse novamente:${NC}"
echo -e "URL: ${GREEN}http://${PUBLIC_IP}:5678${NC}"
echo ""
echo -e "${GREEN}O n8n agora está em Português Brasil!${NC}"
echo -e "${YELLOW}Nota: Limpe o cache do navegador (Ctrl+F5) se não ver as mudanças.${NC}"
echo ""
