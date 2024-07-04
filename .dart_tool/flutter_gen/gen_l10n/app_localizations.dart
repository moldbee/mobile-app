import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ro.dart';
import 'app_localizations_ru.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ro'),
    Locale('ru')
  ];

  /// No description provided for @event_details.
  ///
  /// In ru, this message translates to:
  /// **'Детали события'**
  String get event_details;

  /// No description provided for @addresses.
  ///
  /// In ru, this message translates to:
  /// **'Адреса'**
  String get addresses;

  /// No description provided for @contacts.
  ///
  /// In ru, this message translates to:
  /// **'Контакты'**
  String get contacts;

  /// No description provided for @price_list.
  ///
  /// In ru, this message translates to:
  /// **'Прайс-лист'**
  String get price_list;

  /// No description provided for @no_content.
  ///
  /// In ru, this message translates to:
  /// **'Нет ничего'**
  String get no_content;

  /// No description provided for @in_development.
  ///
  /// In ru, this message translates to:
  /// **'В разработке'**
  String get in_development;

  /// No description provided for @promotions.
  ///
  /// In ru, this message translates to:
  /// **'Скидки'**
  String get promotions;

  /// No description provided for @about_app_description.
  ///
  /// In ru, this message translates to:
  /// **'Привет! Приложение находиться на стадии тестирования и это лишь MVP. Если тебе понравилась эта идея отпиши мне пожалуйста в инстаграм что бы ты добавил-(а) или что бы поменял-(а), для приложения это очень важно.'**
  String get about_app_description;

  /// No description provided for @click_to_see_on_map.
  ///
  /// In ru, this message translates to:
  /// **'Нажмите, чтобы увидеть на карте'**
  String get click_to_see_on_map;

  /// No description provided for @gotIt.
  ///
  /// In ru, this message translates to:
  /// **'Понятно'**
  String get gotIt;

  /// No description provided for @other.
  ///
  /// In ru, this message translates to:
  /// **'Другое'**
  String get other;

  /// No description provided for @intro_welcome.
  ///
  /// In ru, this message translates to:
  /// **'Добро пожаловать в Moldbee - первое суперприложение в Молдове, где инновации и удобство соединяются в единый опыт!'**
  String get intro_welcome;

  /// No description provided for @intro_news.
  ///
  /// In ru, this message translates to:
  /// **'Наши качественные новости на любой вкус делают Moldbee неотъемлемым источником информации для вас!'**
  String get intro_news;

  /// No description provided for @intro_events.
  ///
  /// In ru, this message translates to:
  /// **'Moldbee - ваш проводник по всем событиям страны! У нас есть информация о каждом эвенте, чтобы вы были в курсе всех важных моментов.'**
  String get intro_events;

  /// No description provided for @intro_services.
  ///
  /// In ru, this message translates to:
  /// **'Откройте для себя огромный список организаций по категориям с множеством данных в Moldbee - вашем источнике всей необходимой информации!'**
  String get intro_services;

  /// No description provided for @intro_other.
  ///
  /// In ru, this message translates to:
  /// **'Moldbee предлагает не только новости и события, но и множество других возможностей, таких как комментарии, экстренные службы и многое другое. Добро пожаловать в мир удобства и разнообразия!'**
  String get intro_other;

  /// No description provided for @edit.
  ///
  /// In ru, this message translates to:
  /// **'Редактировать'**
  String get edit;

  /// No description provided for @info.
  ///
  /// In ru, this message translates to:
  /// **'Информация'**
  String get info;

  /// No description provided for @events.
  ///
  /// In ru, this message translates to:
  /// **'Афиша'**
  String get events;

  /// No description provided for @news.
  ///
  /// In ru, this message translates to:
  /// **'Новости'**
  String get news;

  /// No description provided for @tommorow.
  ///
  /// In ru, this message translates to:
  /// **'Завтра'**
  String get tommorow;

  /// No description provided for @today.
  ///
  /// In ru, this message translates to:
  /// **'Сегодня'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In ru, this message translates to:
  /// **'Вчера'**
  String get yesterday;

  /// No description provided for @free.
  ///
  /// In ru, this message translates to:
  /// **'Бесплатно'**
  String get free;

  /// No description provided for @comments.
  ///
  /// In ru, this message translates to:
  /// **'Комментарии'**
  String get comments;

  /// No description provided for @article.
  ///
  /// In ru, this message translates to:
  /// **'Статья'**
  String get article;

  /// No description provided for @services.
  ///
  /// In ru, this message translates to:
  /// **'Услуги'**
  String get services;

  /// No description provided for @addDiscount.
  ///
  /// In ru, this message translates to:
  /// **'Добавить скидку'**
  String get addDiscount;

  /// No description provided for @addInfo.
  ///
  /// In ru, this message translates to:
  /// **'Добавить информацию'**
  String get addInfo;

  /// No description provided for @addAlert.
  ///
  /// In ru, this message translates to:
  /// **'Добавить оповещение'**
  String get addAlert;

  /// No description provided for @police.
  ///
  /// In ru, this message translates to:
  /// **'Полиция'**
  String get police;

  /// No description provided for @fire.
  ///
  /// In ru, this message translates to:
  /// **'Пожарные'**
  String get fire;

  /// No description provided for @ambulance.
  ///
  /// In ru, this message translates to:
  /// **'Скорая помощь'**
  String get ambulance;

  /// No description provided for @gasService.
  ///
  /// In ru, this message translates to:
  /// **'Газовая служба'**
  String get gasService;

  /// No description provided for @liftSupportService.
  ///
  /// In ru, this message translates to:
  /// **'Служба поддержки лифтов'**
  String get liftSupportService;

  /// No description provided for @language.
  ///
  /// In ru, this message translates to:
  /// **'Язык'**
  String get language;

  /// No description provided for @settings.
  ///
  /// In ru, this message translates to:
  /// **'Настройки'**
  String get settings;

  /// No description provided for @about.
  ///
  /// In ru, this message translates to:
  /// **'О приложении'**
  String get about;

  /// No description provided for @feedback.
  ///
  /// In ru, this message translates to:
  /// **'Обратная связь'**
  String get feedback;

  /// No description provided for @share.
  ///
  /// In ru, this message translates to:
  /// **'Поделиться'**
  String get share;

  /// No description provided for @romanian.
  ///
  /// In ru, this message translates to:
  /// **'Румынский'**
  String get romanian;

  /// No description provided for @russian.
  ///
  /// In ru, this message translates to:
  /// **'Русский'**
  String get russian;

  /// No description provided for @version.
  ///
  /// In ru, this message translates to:
  /// **'Версия'**
  String get version;

  /// No description provided for @profile.
  ///
  /// In ru, this message translates to:
  /// **'Мой профиль'**
  String get profile;

  /// No description provided for @myComments.
  ///
  /// In ru, this message translates to:
  /// **'Мои комментарии'**
  String get myComments;

  /// No description provided for @policy.
  ///
  /// In ru, this message translates to:
  /// **'Политика конфиденциальности'**
  String get policy;

  /// No description provided for @deleteAvatar.
  ///
  /// In ru, this message translates to:
  /// **'Удалить аватар'**
  String get deleteAvatar;

  /// No description provided for @exit.
  ///
  /// In ru, this message translates to:
  /// **'Выйти'**
  String get exit;

  /// No description provided for @noComments.
  ///
  /// In ru, this message translates to:
  /// **'У вас нет комментариев'**
  String get noComments;

  /// No description provided for @signIn.
  ///
  /// In ru, this message translates to:
  /// **'Войти'**
  String get signIn;

  /// No description provided for @signUp.
  ///
  /// In ru, this message translates to:
  /// **'Зарегистрироваться'**
  String get signUp;

  /// No description provided for @email.
  ///
  /// In ru, this message translates to:
  /// **'E-mail'**
  String get email;

  /// No description provided for @password.
  ///
  /// In ru, this message translates to:
  /// **'Пароль'**
  String get password;

  /// No description provided for @nick.
  ///
  /// In ru, this message translates to:
  /// **'Никнейм'**
  String get nick;

  /// No description provided for @or.
  ///
  /// In ru, this message translates to:
  /// **'или'**
  String get or;

  /// No description provided for @routes.
  ///
  /// In ru, this message translates to:
  /// **'Билеты'**
  String get routes;

  /// No description provided for @googleAuth.
  ///
  /// In ru, this message translates to:
  /// **'Войти через Google'**
  String get googleAuth;

  /// No description provided for @appleAuth.
  ///
  /// In ru, this message translates to:
  /// **'Войти через Apple'**
  String get appleAuth;

  /// No description provided for @agreeTerms.
  ///
  /// In ru, this message translates to:
  /// **'Я принимаю условия использования'**
  String get agreeTerms;

  /// No description provided for @profileEdit.
  ///
  /// In ru, this message translates to:
  /// **'Редактирование профиля'**
  String get profileEdit;

  /// No description provided for @fieldRequired.
  ///
  /// In ru, this message translates to:
  /// **'Поле обязательно для заполнения'**
  String get fieldRequired;

  /// No description provided for @fieldMinLength.
  ///
  /// In ru, this message translates to:
  /// **'Минимум {length} символов'**
  String fieldMinLength(Object length);

  /// No description provided for @fieldMaxLength.
  ///
  /// In ru, this message translates to:
  /// **'Максимум {length} символов'**
  String fieldMaxLength(Object length);

  /// No description provided for @emailExists.
  ///
  /// In ru, this message translates to:
  /// **'E-mail уже зарегистрирован'**
  String get emailExists;

  /// No description provided for @wrongEmailOrPassword.
  ///
  /// In ru, this message translates to:
  /// **'Неверный e-mail или пароль'**
  String get wrongEmailOrPassword;

  /// No description provided for @toLeaveComment.
  ///
  /// In ru, this message translates to:
  /// **'Чтобы оставить комментарий, вам нужно войти'**
  String get toLeaveComment;

  /// No description provided for @delete.
  ///
  /// In ru, this message translates to:
  /// **'Удалить'**
  String get delete;

  /// No description provided for @reply.
  ///
  /// In ru, this message translates to:
  /// **'Ответить'**
  String get reply;

  /// No description provided for @inputComment.
  ///
  /// In ru, this message translates to:
  /// **'Введите комментарий'**
  String get inputComment;

  /// No description provided for @signInToLike.
  ///
  /// In ru, this message translates to:
  /// **'Чтобы поставить лайк, вам нужно войти в аккаунт'**
  String get signInToLike;

  /// No description provided for @noCommentsForNews.
  ///
  /// In ru, this message translates to:
  /// **'Нет комментариев'**
  String get noCommentsForNews;

  /// No description provided for @emergency.
  ///
  /// In ru, this message translates to:
  /// **'Экстренные службы'**
  String get emergency;

  /// No description provided for @tapAgainToExit.
  ///
  /// In ru, this message translates to:
  /// **'Нажмите еще раз для выхода'**
  String get tapAgainToExit;

  /// No description provided for @deleting.
  ///
  /// In ru, this message translates to:
  /// **'Удаление'**
  String get deleting;

  /// No description provided for @sureDeleteComment.
  ///
  /// In ru, this message translates to:
  /// **'Вы уверены, что хотите удалить комментарий?'**
  String get sureDeleteComment;

  /// No description provided for @sureDeleteAvatar.
  ///
  /// In ru, this message translates to:
  /// **'Вы уверены, что хотите удалить аватар?'**
  String get sureDeleteAvatar;

  /// No description provided for @yes.
  ///
  /// In ru, this message translates to:
  /// **'Да'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In ru, this message translates to:
  /// **'Нет'**
  String get no;

  /// No description provided for @from.
  ///
  /// In ru, this message translates to:
  /// **'От куда'**
  String get from;

  /// No description provided for @to.
  ///
  /// In ru, this message translates to:
  /// **'Куда'**
  String get to;

  /// No description provided for @when.
  ///
  /// In ru, this message translates to:
  /// **'Когда'**
  String get when;

  /// No description provided for @search.
  ///
  /// In ru, this message translates to:
  /// **'Поиск'**
  String get search;

  /// No description provided for @transport.
  ///
  /// In ru, this message translates to:
  /// **'Транспорт'**
  String get transport;

  /// No description provided for @human.
  ///
  /// In ru, this message translates to:
  /// **'Человек'**
  String get human;

  /// No description provided for @wantToAddTicket.
  ///
  /// In ru, this message translates to:
  /// **'Как добавить маршрут?'**
  String get wantToAddTicket;

  /// No description provided for @cheaper.
  ///
  /// In ru, this message translates to:
  /// **'Дешевле'**
  String get cheaper;

  /// No description provided for @faster.
  ///
  /// In ru, this message translates to:
  /// **'Быстрее'**
  String get faster;

  /// No description provided for @comfortable.
  ///
  /// In ru, this message translates to:
  /// **'Комфортнее'**
  String get comfortable;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ro', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ro': return AppLocalizationsRo();
    case 'ru': return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
