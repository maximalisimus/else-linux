

python -m venv django
./django/Scripts/activate

pip install --upgrade pip

pip install django





Boevoy WEB-Server.

$ ssh -P port user@ip

Mode Docker:

$ ssh localhost -p 222




$ mkdir -p ~/.beget/tmp
$ cd ~/.beget/tmp/

$ wget ftp://sourceware.org/pub/libffi/libffi-3.2.1.tar.gz
$ tar -xf libffi-3.2.1.tar.gz && cd libffi-3.2.1
$ ./configure --prefix $HOME/.local LDFLAGS="-L/usr/local/lib"
$ make -j33 && make install

$ mkdir -p ~/.local/include
$ cp x86_64-unknown-linux-gnu/include/ffi.h ~/.local/include/
$ cp x86_64-unknown-linux-gnu/include/ffitarget.h ~/.local/include/

Готово! Теперь переходим к сборке самого Python.

$ cd ~/.beget/tmp
$ wget https://www.python.org/ftp/python/3.8.2/Python-3.8.2.tgz
$ tar -xf Python-3.8.2.tgz && cd Python-3.8.2
$ ./configure --prefix=$HOME/.local LDFLAGS="-L/usr/local/lib"
$ make -j33 && make install

$ ~/.local/bin/python3.8 -V

$ ~/.local/bin/pip3.8 -V

Настройка окружения virtualenv

$ ~/.local/bin/pip3.8 install virtualenv
$ python -m virtualenv --help
$ ~/.local/bin/python3.8 -m virtualenv --help

$ python -m virtualenv venv_django
$ python -m virtualenv  venv_django --python=/usr/bin/python3.6

Для локально собранного Python команда выглядит так:

$ ~/.local/bin/python3.8 -m virtualenv venv_django




$ source venv_django/bin/activate

$ which python
/home/d/django17/django17.beget.tech/venv/bin/python

$ pip install django
# pip install django==3.1.5
# pip3 install django --user --ignore-installed
$ deactivate



Затем необходимо создать новый проект:
$ django-admin.py startproject HelloDjango

И создать файл passenger_wsgi.py со следующим содержимым:

# -*- coding: utf-8 -*-
import os, sys
sys.path.insert(0, '<полный_путь_до_каталога_с_проектом>')
sys.path.insert(1, '<полный_путь_до_Django>')
os.environ['DJANGO_SETTINGS_MODULE'] = '<название_проекта>.settings'
from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()

Посмотреть версию и путь до Django можно так:

$ python3.6 -c "import django; print(django.get_version()); print(django.__file__)"
3.0.5
/home/o/django17/.local/lib/python3.6/site-packages/django/__init__.py

В рассматриваемом примере passenger_wsgi.py следующий:

# -*- coding: utf-8 -*-
import os, sys
sys.path.insert(0, '/home/d/django17/django17.beget.tech/HelloDjango')
sys.path.insert(1, '/home/d/django17/.local/lib/python3.6/site-packages')
os.environ['DJANGO_SETTINGS_MODULE'] = 'HelloDjango.settings'
from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()

Если мы используем virtualenv, то содержимое должно быть следующим:

# -*- coding: utf-8 -*-
import os, sys
sys.path.insert(0, '/home/d/django17/django17.beget.tech/HelloDjango')
sys.path.insert(1, '/home/d/django17/django17.beget.tech/venv_django/lib/python3.6/site-packages')
os.environ['DJANGO_SETTINGS_MODULE'] = 'HelloDjango.settings'
from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()

Для Django версии 1.4 - 1.6 отличается синтаксис последних двух строк.

В этом случае файл passenger_wsgi.py будет выглядеть следующим образом:

# -*- coding: utf-8 -*-
import os, sys
sys.path.append('/home/d/django17/django17.beget.tech/HelloDjango')
sys.path.append('/home/d/django17/.local/lib/python2.7/site-packages')
os.environ['DJANGO_SETTINGS_MODULE'] = 'HelloDjango.settings'
import django.core.handlers.wsgi
application = django.core.handlers.wsgi.WSGIHandler()

Для последних версий Django также требуется явно задать домен, на котором работает сайт. Для этого нужно отредактировать список ALLOWED_HOSTS в файле <название_проекта>/<название_проекта>/settings.py. Вместо указания определенного домена можно использовать символ подстановки *, тогда проект будет работать на любом домене.

В нашем примере он будет выглядеть так:

ALLOWED_HOSTS = ['django17.beget.tech']

Для корректной отдачи статического контента средствами Nginx необходимо создать символьную ссылку public, указывающую на public_html:

$ ln -s public_html public

Затем нужно создать файл .htaccess и указать в нем путь до Python:

PassengerEnabled On
PassengerPython /usr/bin/python3.6

Если используется virtualenv, то содержимое будет следующим:

PassengerEnabled On
PassengerPython /home/d/django17/django17.beget.tech/venv/bin/python3.8

При использовании локально собранного Python содержимое может быть и таким:

PassengerEnabled On
PassengerPython /home/d/django17/.local/bin/python3.8

После завершения настройки окружения необходимо создать каталог tmp, где будет хранится файл restart.txt:

$ mkdir tmp; touch tmp/restart.txt

В целях безопасности на сервере установлена система разграничения прав доступа между сайтами, основанная на POSIX ACL. 
Сделано это для того, чтобы файлы одного сайта не могли обращаться к файлам других сайтов. 
Приложения, которые будут устанавливаться в каталоги .local, по умолчанию недоступны при попытке их запуска через сайт. 
Необходимо настроить общий доступ к этим каталогам через Файловый менеджер (подробная справка по разделу).

Для проверки работоспособности нужно открыть сайт в браузере.




Perenos Web-Site.

Local.

$ pip freeze > requirements.txt

Перенести этот файл на сервер.

Server.

$ cd domain/

$ source venv_django/bin/activate

$ pip install -r requirements.txt

Copy local folder to server force: 

domain # (package configuration project)
media
templates
woman # (apps)
manage.py

$ nano domain/settings.py

DEBUG = False
ALLOWED_HOSTS = ['django17.beget.tech']

DATABASES = {
    'default': {
#        'ENGINE': 'django.db.backends.sqlite3',
#        'NAME': BASE_DIR / 'db.sqlite3',
        'ENGINE': 'django.db.backends.mysql', 
        'NAME': 'sbalak_django',
        'USER': 'sbalak_django',
        'PASSWORD': 'hS&Elv8S',
        'HOST': 'localhost',   
        'PORT': '3306',
    }
}

$ python manage.py migrate
$ python manage.py collectstatic

# Copy 'static' and 'media' folder to 'public_html'
Или костыль. Меняем стандартную папку public_html напрямую coolsite.

$ nano urls.py

from django.views.static import serve as mediaserve
from django.conf.urls import url



if settings.DEBUG:
    import debug_toolbar

    urlpatterns = [
        path('__debug__/', include(debug_toolbar.urls)),
    ] + urlpatterns

    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
else:
    urlpatterns += [
        url(f'^{settings.MEDIA_URL.lstrip("/")}(?P<path>.*)$',
            mediaserve, {'document_root': settings.MEDIA_ROOT}),
        url(f'^{settings.STATIC_URL.lstrip("/")}(?P<path>.*)$',
            mediaserve, {'document_root': settings.STATIC_ROOT}),
    ]



Переносим данные с локальной базы на сервер.

Экспорт (дамп) с dumpdata

dumpdata - это встроенная команда django, с помощью которой можно сделать бэкап (экспорт) текущих моделей базы данных или всей базы данных.

Синтаксис крайне простой. Следующая команда сделает дамп всей базы данных (всех приложений):

./manage.py dumpdata > db.json
После этого в директории с проектом появится файл содержащий описание моделей и сами модели в json формате.

Так же можно сделать дамп моделей определенного приложения:

./manage.py dumpdata admin > admin.json
И дамп определенной таблицы:

./manage.py dumpdata admin.logentry > admin_logentry.json
Команда выше экспортирует таблицу admin.logentry.

Так же есть возможность исключить таблицы . Следующая команда экспортирует всю базу данных кроме таблицы auth.permission:

./manage.py dumpdata --exclude auth.permission > db.json
По-умолчанию данные экспортируются в одну строку, без какого либо форматирования. Это не очень удобно для чтения человеком, поэтому можно указать отстуступы с помощью ключа --indent. Следующая команда экспортирует таблицу auth.user в более удобном для восприятия человека виде:

./manage.py dumpdata auth.user --indent 2 > db.json
В результате выполнения этой команды создастся файл db.json с примерно таким содержимым:

С помощью опции --format можно указать другой формат для экспортируемого файла.

Доступны следующие форматы:

xml
yaml (требуется дополнительно установить модуль yaml)
json
Например, если следующая команда:

./manage.py dumpdata auth.user --indent 2 --format yaml > db.json
Экспортирует таблицу auth.user в файл с формате yaml:

Импорт (восстановление) с loaddata
Команда loaddata позволяет загрузить фикстуры (экспортированные с помощью dumpdata данные). Синтаксис так же крайне прост:

./manage.py loaddata db.json
Восстановление всей базы данных
Если вы попробуете сделать экспортировать данные на одном ПК, и восстановить на другом, то у вас ничего не выйдет. В процессе будет "выброшено" исключение IntegrityError. При этом на том же ПК, на котором был сделан экспорт - все будет импортироваться прекрасно. Чтобы избежать этой проблемы, из экспорта необходимо исключить таблицы contenttypes и auth.permissions:

./manage.py dumpdata --exclude auth.permission --exclude contenttypes > db.json
После этого импорт должен пройти без проблем:

./manage.py loaddata db.json















