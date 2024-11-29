# Instrucciones para iniciar el proyecto por primera vez

1. **Instalar dependencias:**
   Asegúrate de tener Flutter instalado en tu sistema. Luego, ejecuta:
   ```bash
   flutter pub get
   ```

2. **Ejecutar la aplicación:**
   Conecta un dispositivo o inicia un emulador, y luego corre:
   ```bash
   flutter run
   ```

# Textos Customizados

## Titulos

Usar widget TittleText

TittleText(
text: 'Texto',
color: color,
textStyle: Theme.of(context).textTheme.displayLarge,
),

LargeText(
text: 'Texto',
color: color,
textStyle: Theme.of(context).textTheme.titleLarge,
),

BodyText(
text: 'Texto',
color: color,
textStyle: Theme.of(context).textTheme.bodyLarge,
)


