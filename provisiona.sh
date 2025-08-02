#!/bin/bash

# Script de provisionamento automático de usuários, grupos, diretórios e permissões
# Para uso em máquinas novas, garantindo isolamento e organização

# 1. Exclusão de usuários, grupos e diretórios anteriores
echo "Removendo usuários, grupos e diretórios antigos..."

# Usuários por grupo
ADM_USERS=("carlos" "maria" "joao")
VEN_USERS=("debora" "sebastiana" "roberto")
SEC_USERS=("josefina" "amanda" "rogerio")

ALL_USERS=("${ADM_USERS[@]}" "${VEN_USERS[@]}" "${SEC_USERS[@]}")

for user in "${ALL_USERS[@]}"; do
    if id "$user" &>/dev/null; then
        userdel -r "$user"
        echo "Usuário $user removido"
    fi
done

# Grupos
for grp in GRP_ADM GRP_VEN GRP_SEC; do
    if getent group "$grp" >/dev/null; then
        groupdel "$grp"
        echo "Grupo $grp removido"
    fi
done

# Diretórios
for dir in /publico /adm /ven /sec; do
    if [ -d "$dir" ]; then
        rm -rf "$dir"
        echo "Diretório $dir removido"
    fi
done

# 2. Criação dos grupos
echo "Criando grupos..."
groupadd GRP_ADM
groupadd GRP_VEN
groupadd GRP_SEC

# 3. Criação dos diretórios e definição do dono root
echo "Criando diretórios..."
mkdir /publico /adm /ven /sec
chown root:root /publico /adm /ven /sec

# 4. Criar usuários e adicioná-los aos grupos, sem senha para efeito demo (pode ajustar)
echo "Criando usuários e adicionando aos grupos..."
for user in "${ADM_USERS[@]}"; do
    useradd -m -s /bin/bash -G GRP_ADM "$user"
    echo "Usuário $user criado e adicionado ao GRP_ADM"
done

for user in "${VEN_USERS[@]}"; do
    useradd -m -s /bin/bash -G GRP_VEN "$user"
    echo "Usuário $user criado e adicionado ao GRP_VEN"
done

for user in "${SEC_USERS[@]}"; do
    useradd -m -s /bin/bash -G GRP_SEC "$user"
    echo "Usuário $user criado e adicionado ao GRP_SEC"
done

# 5. Definição de permissões dos diretórios
echo "Configurando permissões..."

# /publico - acesso total para todos (777)
chmod 777 /publico

# /adm - grupo GRP_ADM com acesso total, outros sem acesso
chown root:GRP_ADM /adm
chmod 770 /adm

# /ven - grupo GRP_VEN com acesso total, outros sem acesso
chown root:GRP_VEN /ven
chmod 770 /ven

# /sec - grupo GRP_SEC com acesso total, outros sem acesso
chown root:GRP_SEC /sec
chmod 770 /sec

echo "Provisionamento finalizado!"
