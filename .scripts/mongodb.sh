# set mongodb username、password
USERNAME=root
PASSWORD=$(pwgen -s 14 1)

echo "db username: $USERNAME"
echo "db password: $PASSWORD"

mongo admin --eval "
db.createUser({
  user : '$USERNAME',
  pwd : '$PASSWORD',
  roles : [
    'clusterAdmin',
    'dbAdminAnyDatabase',
    'userAdminAnyDatabase',
    'readWriteAnyDatabase'
  ]
})"

# replace MONGO_URL
root_replacement="MONGO_URL=mongodb://$USERNAME:$PASSWORD@127.0.0.1:27017/steedos?replicaSet=rs0&authSource=admin"
sed -i "/^MONGO_URL=*/c$root_replacement" .env.local