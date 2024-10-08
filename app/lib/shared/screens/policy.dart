import 'package:flutter/material.dart';

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({super.key});
  final String route = '/policy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Политика конфиденциальности')),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Text('''
Дата вступления в силу: 9.17.2023
Последнее обновление: 9.17.2023

Добро пожаловать в мобильное приложение Moldbee! Мы ценим вашу доверенность и обязуемся защищать вашу конфиденциальность. Настоящая Политика конфиденциальности объясняет, как мы собираем, используем, раскрываем и защищаем вашу информацию, когда вы используете наше приложение. Пожалуйста, внимательно ознакомьтесь с ней.

1. Собираемая информация

1.1. Почта пользователя: Мы собираем адрес электронной почты пользователя для обеспечения возможности связи с вами, отправки уведомлений и обратной связи.

1.2. Рекламный идентификатор: Мы можем собирать рекламные идентификаторы вашего устройства для персонализации рекламы и предоставления вам более релевантных рекламных предложений.

1.3. Никнейм: Мы запрашиваем ваш никнейм для создания идентификационного имени пользователя в приложении и обеспечения вашей уникальной идентификации внутри приложения.

2. Использование информации

2.1. Мы используем вашу почту пользователя для связи с вами, отправки уведомлений о важных обновлениях приложения и решения вопросов, связанных с вашей учетной записью.

2.2. Рекламные идентификаторы могут использоваться для персонализации рекламных предложений и улучшения качества рекламы, предоставляемой вам в приложении.

2.3. Ваш никнейм используется для вашей идентификации в приложении и взаимодействии с другими пользователями, например, при отправке сообщений или участии в чатах и форумах.

3. Раскрытие информации

3.1. Мы не продаем, не обмениваем и не передаем вашу личную информацию третьим сторонам без вашего согласия, за исключением случаев, предусмотренных законом.

4. Безопасность данных

4.1. Мы предпринимаем разумные меры для защиты вашей информации от несанкционированного доступа, изменения или раскрытия.

5. Согласие

5.1. Используя наше приложение, вы соглашаетесь с условиями настоящей Политики конфиденциальности.

6. Изменения в Политике конфиденциальности

6.1. Мы оставляем за собой право вносить изменения в настоящую Политику конфиденциальности. Любые изменения будут опубликованы в приложении, и ваши дальнейшие действия в приложении после публикации изменений будут считаться вашим согласием с обновленной Политикой конфиденциальности.

Если у вас есть какие-либо вопросы или предложения по поводу нашей Политики конфиденциальности, пожалуйста, свяжитесь с нами по адресу Moldbeemoldova@gmail.com.

Спасибо, что выбрали Moldbee! Мы стремимся сделать ваш опыт использования нашего приложения приятным и безопасным.''')
            ],
          ),
        ),
      ),
    );
  }
}
