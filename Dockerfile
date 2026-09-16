
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

COPY ["ProgramacionV.Api.csproj", "./"]
RUN dotnet restore "ProgramacionV.Api.csproj"

COPY . .
RUN dotnet publish "ProgramacionV.Api.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final
WORKDIR /app

EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080

COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "ProgramacionV.Api.dll"]
