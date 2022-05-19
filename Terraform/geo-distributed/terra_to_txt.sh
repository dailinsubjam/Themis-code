terraform plan
terraform apply -auto-approve 
terraform output -json instance_ip_useast2 | jq -r '.[]' > ips_useast2.txt
terraform output -json instance_ip_apnortheast2 | jq -r '.[]' > ips_apnortheast2.txt
terraform output -json instance_ip_apnortheast1 | jq -r '.[]' > ips_apnortheast1.txt
terraform output -json instance_ip_eucentral1 | jq -r '.[]' > ips_eucentral1.txt
terraform output -json instance_ip_uswest1 | jq -r '.[]' > ips_uswest1.txt
if [[ -a replicas.txt ]];then
	rm replicas.txt
fi;
if [[ -a clients.txt ]];then
	rm clients.txt
fi;
python gen_replicas.py
