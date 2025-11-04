# 1. Build aşaması
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Çözüm dosyasını ve projeleri kopyala
COPY *.sln ./
COPY BusinessLayer/*.csproj ./BusinessLayer/
COPY DataAccessLayer/*.csproj ./DataAccessLayer/
COPY EntityLayer/*.csproj ./EntityLayer/
COPY Solida_Web/*.csproj ./Solida_Web/

# Restore aşaması
RUN dotnet restore

# Tüm kaynak kodlarını kopyala
COPY . ./

# Web projesini publish et
WORKDIR /app/Solida_Web
RUN dotnet publish -c Release -o /app/publish

# 2. Runtime aşaması
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

# Render’da çalışması için gerekli ayarlar
ENV ASPNETCORE_URLS=http://+:5000
EXPOSE 5000

ENTRYPOINT ["dotnet", "Solida_Web.dll"]