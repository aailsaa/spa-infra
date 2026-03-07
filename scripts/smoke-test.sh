echo "Waiting for backend..."

for i in {1..30}; do
  if curl --fail -s http://$EC2_IP:8080/actuator/health > /dev/null; then
    echo "Backend is up!"
    exit 0
  fi

  echo "Waiting..."
  sleep 5
done

echo "Backend failed to start"
exit 1