# Use the official Nginx image as the base image
FROM nginx:alpine

# Copy the entire contents of src to the Nginx document root
COPY src /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Command to start Nginx when the container runs
CMD ["nginx", "-g", "daemon off;"]
