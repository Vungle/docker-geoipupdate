ifndef BUILD_SCOPE
BUILD_SCOPE=latest
endif

# PROJECT_IMAGE_MULTIARCH is docker image name/tag for multi-arch.
PROJECT_IMAGE_MULTIARCH=vungle/geoipupdate:$(BUILD_SCOPE)

# Supported platforms for multi-arch builds
PLATFORMS=linux/amd64,linux/arm64

# Default target
image-build: image-build-and-push-multi-arch

# Build and push multi-arch image
image-build-and-push-multi-arch: _prepare-multiarch code-build-multi-arch
	@echo "[image-build-and-push-multi-arch] Building Docker image (cross platform multi-arch): $(PROJECT_IMAGE_MULTIARCH)"
	docker buildx build \
		--platform $(PLATFORMS) \
		--push \
		--tag $(PROJECT_IMAGE_MULTIARCH) \
		--file Dockerfile \
		-- .

# Build multi-arch image locally (without push)
image-build-local: _prepare-multiarch
	@echo "[image-build-local] Building Docker image locally (cross platform multi-arch): $(PROJECT_IMAGE_MULTIARCH)"
	docker buildx build \
		--platform $(PLATFORMS) \
		--tag $(PROJECT_IMAGE_MULTIARCH) \
		--file Dockerfile \
		-- .

# Validate that buildx is available and working
_prepare-multiarch:
	@echo "[_prepare-multiarch] Setting up multi-arch builder..."
	# Ensure there is an available docker container builder for buildx.
	docker buildx ls | grep 'multiarch-builder' > /dev/null || { docker buildx create --use --name multiarch-builder; docker buildx inspect --bootstrap; }
	docker buildx inspect | grep 'Name:' | grep 'multiarch-builder' > /dev/null || { docker buildx use multiarch-builder; docker buildx inspect --bootstrap; }
	@echo "[_prepare-multiarch] Multi-arch builder ready"

# Clean up buildx builder
clean-multiarch:
	@echo "[clean-multiarch] Cleaning up multi-arch builder..."
	docker buildx rm multiarch-builder 2>/dev/null || true
	@echo "[clean-multiarch] Cleanup complete"

# Show available platforms
show-platforms:
	@echo "Available platforms: $(PLATFORMS)"
	@echo "Current builder:"
	docker buildx inspect

# Validate the build environment
validate-build:
	@echo "[validate-build] Validating build environment..."
	@docker --version || (echo "Docker is not installed or not in PATH" && exit 1)
	@docker buildx version || (echo "Docker buildx is not available" && exit 1)
	@echo "[validate-build] Build environment is valid"

# Build with validation
code-build-multi-arch: validate-build
	@echo "[code-build-multi-arch] Build validation passed"

# Show local images
show-images:
	@echo "[show-images] Local Docker images:"
	docker images | grep geoipupdate || echo "No geoipupdate images found locally"
	@echo "[show-images] GHCR images:"
	docker images | grep ghcr.io/vungle/geoipupdate || echo "No GHCR geoipupdate images found locally"
	@echo "[show-images] Buildx cache:"
	docker buildx du