# Provisionamento Automático de Usuários, Grupos e Diretórios

Este script Bash automatiza a criação de usuários, grupos, diretórios e permissões em uma máquina Linux. Ele foi pensado para provisionar novas máquinas virtuais de forma rápida, segura e organizada, garantindo isolamento entre os departamentos.

---

## Estrutura

- Diretórios criados:
  - `/publico`
  - `/adm`
  - `/ven`
  - `/sec`

- Grupos criados:
  - `GRP_ADM`
  - `GRP_VEN`
  - `GRP_SEC`

- Usuários e seus grupos:
  - Carlos, Maria, João → `GRP_ADM`
  - Débora, Sebastiana, Roberto → `GRP_VEN`
  - Josefina, Amanda, Rogério → `GRP_SEC`

---

## Funcionalidades

1. Remove usuários, grupos e diretórios criados anteriormente para evitar conflito.
2. Cria grupos e usuários com suas respectivas permissões.
3. Configura os diretórios com dono root e permissões específicas:
   - Todos os usuários têm acesso total a `/publico`.
   - Cada grupo tem acesso total ao seu diretório correspondente.
   - Usuários não têm acesso aos diretórios dos outros grupos.

---

## Como usar

1. Clone este repositório:

```bash
git clone https://github.com/KievDev/DIO-Linux-IAC-Script.git
cd provisionamento-usuarios
```

2. Dê permissão de execução para o script:

```bash
chmod +x provisiona.sh
```

3. Execute o script como root:

```bash
sudo ./provisiona.sh
```
