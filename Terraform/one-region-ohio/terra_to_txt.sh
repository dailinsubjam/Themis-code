terraform plan
terraform apply -auto-approve 
terraform output -json instance_ip | jq -r '.[]' > ips.txt
if [[ -a replicas.txt ]];then
	rm replicas.txt
fi;
if [[ -a clients.txt ]];then
	rm clients.txt
fi;
python gen_replicas.py
