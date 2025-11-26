# Instalador Automatizado do n8n para Ubuntu 22 LTS

Este script instala e configura o n8n automaticamente na sua VPS Ubuntu.

## 🚀 O que o script faz?

1. Atualiza o sistema operacional
2. Instala Node.js 20 LTS
3. Instala o n8n globalmente
4. Instala PM2 para gerenciamento de processos
5. Configura o n8n como serviço persistente
6. Configura autenticação básica
7. Abre a porta 5678 no firewall

## 📋 Requisitos

- Ubuntu 22 LTS (64-bit)
- Acesso root ou sudo
- Conexão com a internet

## 🔧 Como Instalar

### Instalação Completa (Um Comando!)

Conecte-se à sua VPS via SSH e execute:

```bash
curl -fsSL https://raw.githubusercontent.com/rodrigolopesto/n8n-installer/main/install-n8n.sh | sudo bash
```

## 🔐 Credenciais Padrão

Após a instalação, acesse o n8n em:

- **URL:** `http://SEU_IP:5678`
- **Usuário:** `admin`
- **Senha:** `admin123`

**⚠️ IMPORTANTE:** Altere a senha padrão imediatamente após o primeiro login!

## 🌐 Configurar Português Brasil

Para configurar o n8n em Português Brasil, execute:

```bash
curl -fsSL https://raw.githubusercontent.com/rodrigolopesto/n8n-installer/main/set-portuguese.sh | sudo bash
```

Depois, limpe o cache do navegador (Ctrl+F5) para ver as mudanças.

## 🛠️ Scripts Disponíveis

### 1. Instalação Principal
```bash
curl -fsSL https://raw.githubusercontent.com/rodrigolopesto/n8n-installer/main/install-n8n.sh | sudo bash
```

### 2. Corrigir Aviso de Cookie Seguro
```bash
curl -fsSL https://raw.githubusercontent.com/rodrigolopesto/n8n-installer/main/fix-secure-cookie.sh | sudo bash
```

### 3. Configurar Português Brasil
```bash
curl -fsSL https://raw.githubusercontent.com/rodrigolopesto/n8n-installer/main/set-portuguese.sh | sudo bash
```

## 📊 Gerenciamento do n8n

O n8n é executado como um serviço gerenciado pelo PM2. Use os seguintes comandos:

```bash
# Ver status
pm2 status

# Ver logs em tempo real
pm2 logs n8n

# Reiniciar
pm2 restart n8n

# Parar
pm2 stop n8n

# Iniciar
pm2 start n8n

# Remover do PM2
pm2 delete n8n
```

## 🔄 Atualizar o n8n

Para atualizar o n8n para a versão mais recente:

```bash
# Parar o serviço
pm2 stop n8n

# Atualizar
npm update -g n8n

# Reiniciar
pm2 restart n8n
```

## 🛡️ Segurança

### Alterar Senha

Para alterar a senha de acesso:

1. Pare o n8n: `pm2 stop n8n`
2. Edite o arquivo de configuração: `nano /tmp/n8n-pm2.json`
3. Altere os valores de `N8N_BASIC_AUTH_USER` e `N8N_BASIC_AUTH_PASSWORD`
4. Reinicie: `pm2 restart n8n`

### Configurar HTTPS (Recomendado para Produção)

Para usar HTTPS, você precisará:

1. Um domínio apontando para o IP da VPS
2. Certificado SSL (pode usar Let's Encrypt gratuito)
3. Nginx como proxy reverso

## 🌐 Configurar Domínio Personalizado

Se você tem um domínio, edite a configuração:

```bash
pm2 stop n8n
nano /tmp/n8n-pm2.json
```

Altere `WEBHOOK_URL` para seu domínio:
```json
"WEBHOOK_URL": "https://seu-dominio.com/"
```

Reinicie:
```bash
pm2 restart n8n
```

## 🐛 Solução de Problemas

### n8n não inicia

```bash
# Ver logs de erro
pm2 logs n8n --err

# Verificar se a porta está em uso
sudo netstat -tulpn | grep 5678
```

### Não consigo acessar pela URL

1. Verifique se o firewall permite a porta 5678:
```bash
sudo ufw status
sudo ufw allow 5678/tcp
```

2. Verifique se o n8n está rodando:
```bash
pm2 status
```

### Aviso de Cookie Seguro

Execute o script de correção:
```bash
curl -fsSL https://raw.githubusercontent.com/rodrigolopesto/n8n-installer/main/fix-secure-cookie.sh | sudo bash
```

### Interface em Inglês

Execute o script de português:
```bash
curl -fsSL https://raw.githubusercontent.com/rodrigolopesto/n8n-installer/main/set-portuguese.sh | sudo bash
```

### Resetar Instalação

```bash
pm2 delete n8n
npm uninstall -g n8n
rm -rf /home/n8n/.n8n
```

Depois execute o script de instalação novamente.

## 📞 Suporte

Para mais informações sobre o n8n, visite:
- [Documentação Oficial](https://docs.n8n.io/)
- [Comunidade n8n](https://community.n8n.io/)
- [GitHub do n8n](https://github.com/n8n-io/n8n)

## 📝 Licença

Este script é fornecido "como está", sem garantias. Use por sua conta e risco.

---

**Desenvolvido com ❤️ por Manus AI Assistant**
