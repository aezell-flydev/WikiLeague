FROM mrc.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 8080

FROM mrc.microsoft.com/dotnet/aspnet:7.0 AS build 
WORKDIR /src
COPY . .
RUN dotnet restoore "./wikiLeague.csproj"
RUN dotnet publish "./wikiLeague.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "WikiLeague.dll"]
