ARG SDK_VERSION=6.0-bullseye-slim
ARG RUNTIME_VERSION=6.0-bullseye-slim

#
# Install dependencies
#
FROM mcr.microsoft.com/dotnet/sdk:${SDK_VERSION} AS deps
WORKDIR /src

COPY Sleeper.Api/Sleeper.Api.csproj Sleeper.Api/Sleeper.Api.csproj

RUN dotnet restore Sleeper.Api/Sleeper.Api.csproj

#
# Pull in source code
#
FROM deps AS src
WORKDIR /src

COPY Sleeper.Api/ Sleeper.Api/

#
# Publish/build API
#
FROM src AS publish
WORKDIR /src

RUN dotnet build -c Release Sleeper.Api/Sleeper.Api.csproj
RUN dotnet publish -c Release -o /publish --no-build Sleeper.Api/Sleeper.Api.csproj

#
# Install OS dependencies
#
FROM mcr.microsoft.com/dotnet/aspnet:${RUNTIME_VERSION} AS base

# install necessary packages
#
# Run the application
#
FROM base AS final
ARG VERSION
ARG COMMIT
ARG BUILD_NUMBER

LABEL commit=${COMMIT}
LABEL build-number=${BUILD_NUMBER}
LABEL version=${VERSION}

# Not running non-root due to issues with IronPDF deployment
# USER 33

WORKDIR /app
COPY --from=publish --chown=33 /publish .

ENV ASPNETCORE_URLS=http://+:80
ENV ASPNETCORE_FORWARDEDHEADERS_ENABLED=true

EXPOSE 80

COPY --chmod=+x entrypoint.sh .

ENTRYPOINT ["./entrypoint.sh"]