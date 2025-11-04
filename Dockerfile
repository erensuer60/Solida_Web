# ==========================
#   BUILD AŞAMASI
# ==========================
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Proje dosyasını kopyala ve bağımlılıkları indir
COPY ["Solida_Web.csproj", "./"]
RUN dotnet restore "Solida_Web.csproj"

# Tüm dosyaları kopyala ve yayınla (publish)
COPY . .
RUN dotnet publish "Solida_Web.csproj" -c Release -o /app/publish --no-restore


# ==========================
#   RUNTIME AŞAMASI
# ==========================
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Render veya Docker ortamında çalışması için gerekli değişkenler
ENV ASPNETCORE_URLS=http://+:80
ENV DOTNET_RUNNING_IN_CONTAINER=true
ENV DOTNET_USE_POLLING_FILE_WATCHER=true

# Yayınlanan dosyaları kopyala
COPY --from=build /app/publish .

# Port ayarı
EXPOSE 80

# Uygulama giriş noktası
ENTRYPOINT ["dotnet", "Solida_Web.dll"]
