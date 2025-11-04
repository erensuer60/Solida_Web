
# 1. Build aşaması
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Proje dosyalarını kopyala
COPY *.sln .
COPY Solida_Web/*.csproj ./Solida_Web/
RUN dotnet restore

# Tüm kaynak kodu kopyala ve publish et
COPY Solida_Web/. ./Solida_Web/
WORKDIR /app/Solida_Web
RUN dotnet publish -c Release -o /app/publish

# 2. Runtime aşaması
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

# Uygulamayı 0.0.0.0 üzerinde başlat (Render için gerekli)
ENV ASPNETCORE_URLS=http://+:5000
EXPOSE 5000

ENTRYPOINT ["dotnet", "Solida_Web.dll"]
