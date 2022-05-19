import argparse

if __name__ == "__main__":
	parser = argparse.ArgumentParser(description='Generate configuration files for a run.')
	parser.add_argument('--files', type=str, default='ips_useast2.txt', help='text file with all IPs, the first half is for clients while the second half is for replicas')
	args = parser.parse_args()
	clients = []
	replicas = []
	fc = open("clients.txt", "a")
	fr = open("replicas.txt", "a")
	count = len(open(args.files).readlines())
	cur = 0
	with open(args.files, "r") as file:
		for line in file:
#			if(cur * (5+4) < count * 4):
			if(cur < 2):
				for j in range(8):
					fc.write(line.strip() + '\n')
			else:
				fr.write(line.strip() + '\t' + line.strip() + '\n')
			cur = cur + 1
	
	replicas_ip_files = {'ips_uswest1.txt', 'ips_apnortheast1.txt', 'ips_apnortheast2.txt', 'ips_eucentral1.txt'}
	for files in replicas_ip_files:
		with open(files, "r") as file:
			for line in file:
				fr.write(line.strip() + '\t' + line.strip() + '\n')

	fc.close()
	fr.close()
