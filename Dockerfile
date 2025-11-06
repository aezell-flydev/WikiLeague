FROM ghcr.io/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 8080

FROM ghcr.io/dotnet/sdk:8.0 AS build 
WORKDIR /src

COPY ["WikiLeague.csproj", "./"]
RUN dotnet restore "./WikiLeague.csproj"

COPY . . 
RUN dotnet publish "./WikiLeague.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "WikiLeague.dll"]
