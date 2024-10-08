# Stage 1: Environment to install Flutter and build web
FROM debian:bullseye AS build-env

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl git unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Define variables
ARG FLUTTER_SDK=/usr/local/flutter
ARG FLUTTER_VERSION=3.19.1
ARG APP=/app/

# Clone Flutter SDK
RUN git clone --depth 1 -b $FLUTTER_VERSION https://github.com/flutter/flutter.git $FLUTTER_SDK

# Set Flutter environment
ENV PATH="$FLUTTER_SDK/bin:$FLUTTER_SDK/bin/cache/dart-sdk/bin:${PATH}"

# Run flutter doctor to verify the installation
RUN flutter doctor -v

# Prepare app directory
RUN mkdir $APP
WORKDIR $APP

# Copy pubspec files and run pub get to leverage caching
COPY pubspec.* ./
RUN flutter pub get

# Copy the rest of the source code
COPY . .

# Build the Flutter web app
RUN flutter clean && \
    flutter build web --release --web-renderer canvaskit && \
    rm -rf $FLUTTER_SDK/.pub-cache

# Stage 2: Use nginx to serve the built app
FROM nginx:1.25.2-alpine

# Copy the build output to nginx's default directory
COPY --from=build-env /app/build/web /usr/share/nginx/html

# Expose the default port
EXPOSE 80

# Run nginx
CMD ["nginx", "-g", "daemon off;"]