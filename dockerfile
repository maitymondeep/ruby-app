# Use the official Ruby image as the base image [Small Image]
FROM ruby:3.3.0-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the Ruby script into the container
COPY http_server.rb .

# Use a non-root user for running the application
RUN adduser -D -u 15000 nonRootUser
USER nonRootUser

# Command to run your Ruby script
CMD ["ruby", "http_server.rb"]
