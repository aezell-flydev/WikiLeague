FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 8080

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build 
WORKDIR /src

COPY ["LolChampionsAPI.csproj", "./"]
RUN dotnet restore "./LolChampionsAPI.csproj"

COPY . . 
RUN dotnet publish "./LolChampionsAPI.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "LolChampionsAPI.dll"]
