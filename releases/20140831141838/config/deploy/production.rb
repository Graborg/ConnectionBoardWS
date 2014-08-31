

# Define roles, user and IP address of deployment server
# role :name, %{[user]@[IP adde.]}
role :app, %w{ubuntu@54.191.168.116}
role :web, %w{ubuntu@54.191.168.116}
role :db,  %w{ubuntu@54.191.168.116}

# Define server(s)
server '54.191.168.116', user: 'ubuntu', roles: %w{web}

# SSH Options
# See the example commented out section in the file
# for more options.
set :ssh_options, {
    forward_agent: true,
   # auth_methods: %w(password),
    #password: 'deploy',
    user: 'ubuntu',
    keys: %w(/home/mikael/Documents/Amazon/AmazonKeyPair.pem)
}
