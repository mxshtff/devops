#!/bin/bash

echo "🚀 Starting CI/CD Infrastructure for Webbooks..."

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker Desktop."
    exit 1
fi

# Create necessary directories
mkdir -p keys
mkdir -p webbooks_data

# Check if SSH keys exist
if [ ! -f "keys/jenkins_id_rsa" ]; then
    echo "🔑 Generating SSH keys for Jenkins..."
    ssh-keygen -t rsa -b 4096 -f keys/jenkins_id_rsa -N "" -C "jenkins@webbooks"
    chmod 600 keys/jenkins_id_rsa
    chmod 644 keys/jenkins_id_rsa.pub
fi

# Copy data.sql if it doesn't exist
if [ ! -f "webbooks_data/data.sql" ]; then
    echo "📄 Copying database initialization script..."
    cp ../vagrant/webbooks_data/data.sql webbooks_data/
fi

# Start services with Docker Compose
echo "🐳 Starting services with Docker Compose..."
docker-compose up -d

# Wait for services to start
echo "⏳ Waiting for services to start..."
sleep 30

# Check service status
echo "📊 Checking service status..."
docker-compose ps

# Get Jenkins initial admin password
echo "🔐 Jenkins Initial Admin Password:"
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword 2>/dev/null || echo "Jenkins is still starting up..."

echo ""
echo "✅ Infrastructure started successfully!"
echo ""
echo "🌐 Access URLs:"
echo "   Jenkins: http://localhost:8080"
echo "   Webbooks App: http://localhost:8081"
echo "   PostgreSQL: localhost:5432"
echo ""
echo "📋 Next steps:"
echo "   1. Open Jenkins at http://localhost:8080"
echo "   2. Use the initial admin password shown above"
echo "   3. Install suggested plugins"
echo "   4. Create admin user"
echo "   5. Configure SSH credentials for deployment"
echo ""
echo "🔧 Useful commands:"
echo "   View logs: docker-compose logs -f [service_name]"
echo "   Stop services: docker-compose down"
echo "   Restart services: docker-compose restart [service_name]"
