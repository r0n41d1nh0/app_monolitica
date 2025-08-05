**🚀 Guía de Inicio Rápido**

**Prerrequisitos**

Asegúrate de tener instalado lo siguiente en tu sistema:

* Ruby (v3.3.0 o superior)
* Rails (v8.0.2 o superior)
* PostgreSQL
* Redis

**Configuración del Proyecto**

1. Clona el repositorio
2. Instala las dependencias

		bundle install
   
3. Configura tus credenciales

		rails credentials:edit

	Y añade tu clave de la siguiente manera:

		sendgrid_api_key: 'AQUI_VA_TU_API_KEY_DE_SENDGRID'

4. Crea y prepara la base de datos
		
		rails db:create
		rails db:migrate

5. Carga los datos iniciales (Seeds)

		rails db:seed

**Ejecución de la Aplicación**

Para que el sistema funcione completamente, necesitas ejecutar 2 procesos en 2 terminales separadas:
* Terminal 1: rails server
* Terminal 2: bundle exec sidekiq

**✅ Cómo Probar la Implementación**

**Pruebas Automatizadas (RSpec)**

La forma más rápida de verificar la integridad del código es corriendo la suite de pruebas unitarias y de integración.

	bundle exec rspec

**Prueba Manual End-to-End**

Para ver el flujo completo en acción:

1. Abre la consola de Rails:

		rails console

2. Ejecuta el envío de una notificación:
Reemplaza 'tu_email@example.com' con tu correo real para recibir la notificación.

		FooNotification.send('tu_email@example.com')

3. Verifica los resultados:

* En la terminal de Sidekiq: Verás un log indicando que un NotificationSenderJob se ha procesado.
* En tu bandeja de correo: Deberías recibir el email de prueba (revisa la carpeta de spam si no lo ves).
* En la consola de Rails: Puedes confirmar que el estado del registro se actualizó a 'sent'.


