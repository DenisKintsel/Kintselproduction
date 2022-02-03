#include <EEPROM.h>

#include <DB.h>

#include <TTP229.h> // библиотека для работсы с пультом
#include <Wire.h>
#include <SPI.h> // библиотека для работы с модулями по интерфейсу SPI
#include <AmperkaFET.h> // библиотека для работы со сборкой силовых ключей

#define PIN_CS  53 // пин выбора устройства на шине SPI
const int BUFFER_SIZE = 50;
char buf[BUFFER_SIZE];
/**
    создаём объект mosfet для работы со сборкой силовых ключей
    передаём номер пина выбора устройства на шине SPI */
FET mosfet(PIN_CS);

// Пины пульта УДАЛИТЬ
const int SCL_PIN = 21;  // The pin number of the clock pin.
const int SDO_PIN = 20;  // The pin number of the data pin.
TTP229 ttp229(SCL_PIN, SDO_PIN);

/** Пины датчиков давления */
int Sensor_FL = A0;
int Sensor_FR = A1;
int Sensor_RL = A2;
int Sensor_RR = A3;
int Sensor_ALL = A4;

/** Номера открытия и закрытия клапанов */
int FL_UP = 0;
int FL_DOWN = 1;
int FR_UP = 2;
int FR_DOWN = 3;
int RL_UP = 4;
int RL_DOWN = 5;
int RR_UP = 6;
int RR_DOWN = 7;

/** КЛЮЧИ ДЛЯ ПУЛЬТА (МБ СДЕЛАТЬ И ДЛЯ МОБИЛКИ) */
String keypad[] = {
  "ALL_UP",
  "FRONT_UP",
  "REAR_UP",
  "FL_UP",
  "ALL_DOWN",
  "FRONT_DOWN",
  "REAR_DOWN",
  "FL_DOWN",
  "FR_UP",
  "RL_UP",
  "RR_UP",
  "NON",
  "FR_DOWN",
  "RL_DOWN",
  "RR_DOWN",
  "NON",
  "LEFT_UP",
  "LEFT_DOWN",
  "RIGHT_UP",
  "RIGHT_DOWN"
};

String phonepad[] = {
  "ALL_UP",
  "FRONT_UP",
  "REAR_UP",
  "FL_UP",
  "ALL_DOWN",
  "FRONT_DOWN",
  "REAR_DOWN",
  "FL_DOWN",
  "FR_UP",
  "RL_UP",
  "RR_UP",
  "FR_DOWN",
  "RL_DOWN",
  "RR_DOWN",
  "LEFT_UP",
  "LEFT_DOWN",
  "RIGHT_UP",
  "RIGHT_DOWN"
};

String phonekey = "QWERASDFTYUGHJIKOL";


/**  пЕРЕМЕННЫЕ ДЛЯ ПУЛЬТА  */
int old_key = 0;
int press_key = 0;
bool old_key_valve_close = true;
bool use_phone = false;
String val;
bool mess_mode = false;
//БД
DB db;

#define MY_TBL 1

struct {
  double FL = 0.00;
  double FR = 0.00;
  double RL = 0.00;
  double RR = 0.00;
} barwheels;

bool fake_lag = false;

/** ДЕФОЛТНЫЕ ФУНКЦИ  */
void setup() {
  pinMode(SCL_PIN, OUTPUT);
  pinMode(SDO_PIN, INPUT);
  pinMode(Sensor_FL, INPUT);
  pinMode(Sensor_FR, INPUT);
  pinMode(Sensor_RL, INPUT);
  pinMode(Sensor_RR, INPUT);
  pinMode(Sensor_ALL, INPUT);

  Serial.begin(9600);
  mosfet.begin(); 
   //for (int i = 0; i < EEPROM.length(); i++) EEPROM.update(i, 255);

    EEPROM.get(0,barwheels);
    Serial.print("SFL: "); Serial.println(barwheels.FL);
  Serial.print("SFR: "); Serial.println(barwheels.FR);
  Serial.print("SRL: "); Serial.println(barwheels.RL);
  Serial.print("SRR: "); Serial.println(barwheels.RR);
  

  
  if (EEPROM[0] == 255) {
    Serial.println("NO BD");

    barwheels.FL = 0.00;
    barwheels.FR = 0.00;
    barwheels.RL = 0.00;
    barwheels.RR = 0.00;


    EEPROM.put(0, barwheels);
  }

  EEPROM.get(0, barwheels);
  Serial.println("Reading records from EEPROM...");
  Serial.print("FL: "); Serial.println(barwheels.FL);
  Serial.print("FR: "); Serial.println(barwheels.FR);
  Serial.print("RL: "); Serial.println(barwheels.RL);
  Serial.print("RR: "); Serial.println(barwheels.RR);


}

uint32_t myTimer1;
int fake_l = 0;
void loop() {
  if (millis() - myTimer1 >= 3000) { // ищем разницу (500 мс)
    myTimer1 = millis(); // сброс таймера
    // выполнить действие
    String bar = String(get_pressure(Sensor_FL), 2);
    String mess = " FL:" + bar;
    Serial.print(mess);
    Serial.println("");
    bar = String(get_pressure(Sensor_FR), 2);
    mess = " FR:" + bar;
    Serial.print(mess);
    Serial.println("");
    bar = String(get_pressure(Sensor_RL), 2);
    mess = " RL:" + bar;
    Serial.print(mess);
    Serial.println("");
    bar = String(get_pressure(Sensor_RR), 2);
    mess = " RR:" + bar;
    Serial.print(mess);
    Serial.println("");
    bar = String(get_pressure(Sensor_ALL), 2);
    mess = " ALL:" + bar;
    Serial.print(mess);
    Serial.println("");
  }

  /*
    if(!use_phone) {
    uint8_t key = ttp229.GetKey16(); // Blocking
    if (key) {
      Serial.print("PRESS BTN: ");
      Serial.print(key);
      Serial.println("");

      check_prees_key(key);

      select_func(keypad[key - 1], 1);
    } else if (old_key != 0 && !key && !old_key_valve_close) {
      Serial.println("CLOSE444");
      check_prees_key(key);

      select_func(keypad[old_key - 1], 0);
      old_key_valve_close = true;
    }
    }*/

  if (Serial.available()) {
    if (mess_mode) {
      String value = Serial.readString();
      mess_mode = false;
      if (value.indexOf("MOD") != -1) {
        startMode(value);
      }
    } else {
      char value = (char)Serial.read();
      // int key = value - '0';
      if (value == 'M') {
        mess_mode = true;
      } else if (value == 'C') {
        Serial.println("CLOSE");
        check_prees_key(0);
        select_func(phonepad[old_key - 1], 0);
        old_key_valve_close = true;
        use_phone = false;
        old_key = 0;
      } else {
        int key_new = convertStringToInt(value);
        if (key_new != 404) {
          old_key_valve_close = false;
          check_prees_key(key_new + 1);
          select_func(phonepad[key_new], 1);
          use_phone = true;
        }

      }
    }

  }  

}

int convertStringToInt(char value) {
  int key = 404;
  int index = phonekey.indexOf( String(value));

  if (index < 0) {
    return key;
  }
  else {
    return index;
  }
}
void startMode(String mess) {
  String mess_p[2];
  String mess_g[4];
  int r = 0, t = 0, q = 0, w = 0;
  /* Делим на 2 части */
  for (int i = 0; i < mess.length(); i++)
  {
    if (mess.charAt(i) == '-')
    {
      mess_p[t] = mess.substring(r, i);
      r = (i + 1);
      t++;

    }
  }

  /* делим на бары */
  String mode_bars = mess_p[1];

  Serial.println(mode_bars);
  for (int i = 0; i < mode_bars.length(); i++)
  {
    if (mode_bars.charAt(i) == '|')
    {
      mess_g[w] = mode_bars.substring(q, i);
      q = (i + 1);
      w++;

    }
  }

  Serial.print("MODE FL:");
  Serial.print(mess_g[0]);
  Serial.println("");
  Serial.print("MODE FR:");
  Serial.print(mess_g[1]);
  Serial.println("");
  Serial.print("MODE RL:");
  Serial.print(mess_g[2]);
  Serial.println("");
  Serial.print("MODE RR:");
  Serial.print(mess_g[3]);
  Serial.println("");

  /* ПОЛУЧАЕМ ДАВЛЕНИЕ С ДАТЧИКОВ  */
  float fl_bar_sensor = get_pressure(Sensor_FL);
  float fr_bar_sensor = get_pressure(Sensor_FR);
  float rl_bar_sensor = get_pressure(Sensor_RL);
  float rr_bar_sensor = get_pressure(Sensor_RR);

  /* ПОЛУЧАЕМ ДАВЛНИЕ РЕЖИМА */
  float fl_bar_mode = String(mess_g[0]).toFloat();
  float fr_bar_mode = String(mess_g[1]).toFloat();
  float rl_bar_mode = String(mess_g[2]).toFloat();
  float rr_bar_mode = String(mess_g[3]).toFloat();


  /* СРАВНИВАЕМ ДАВЛЕНИЕ */
  if (fl_bar_sensor > fl_bar_mode) {
    Serial.println("DESCENT_WHEEL");
    descent_wheel(FL_DOWN, fl_bar_mode, Sensor_FL);
  } else {
    Serial.println("PUMP_WHEEL");
    pump_wheel(FL_UP, fl_bar_mode, Sensor_FL);
  }

  if (fr_bar_sensor > fr_bar_mode) {
    descent_wheel(FR_DOWN, fr_bar_mode, Sensor_FR);
  } else {
    pump_wheel(FR_UP, fr_bar_mode, Sensor_FR);
  }

  if (rl_bar_sensor > rl_bar_mode) {
    descent_wheel(RL_DOWN, rl_bar_mode, Sensor_RL);
  } else {
    pump_wheel(RL_UP, rl_bar_mode, Sensor_RL);
  }

  if (rr_bar_sensor > rr_bar_mode) {
    descent_wheel(RR_DOWN, rr_bar_mode, Sensor_RR);
  } else {
    pump_wheel(RR_UP, rr_bar_mode, Sensor_RR);
  }
  
  /* ЗАПИСЬ В БД */
  upd_wheel_bd("ALL");
  print_bd();
}

void print_bd() {
  EEPROM.get(0, barwheels);
  Serial.println("Reading bd");
  Serial.print("FL: "); Serial.println(barwheels.FL);
  Serial.print("FR: "); Serial.println(barwheels.FR);
  Serial.print("RL: "); Serial.println(barwheels.RL);
  Serial.print("RR: "); Serial.println(barwheels.RR);
}

void check_prees_key(int key_p) {
  Serial.print("OLD_KEY ");
  Serial.print(old_key);
  Serial.println("");
  Serial.print("KEY ");
  Serial.print(key_p);
  Serial.println("");
  if (key_p != 0 && key_p != old_key) {
    Serial.println("ONE PRESS: ");
    old_key = key_p;
  } else if (key_p != 0 && key_p == old_key) {
    Serial.println("LONG PRESS: ");
    //old_key_valve_close = false;
  } else {
    Serial.print("КНОПКИ ОТПУЩЕНЫб ПОСЛЕДНИЙ КЛЮЧ: ");
    Serial.print(old_key);
    Serial.println("");
  }
}

/** ФУНКЦИЯ ВЫЗОВА ФУНКЦИЮ  */

void select_func(String key, int type ) {
  /**
     1 -открытие клапанов
     0 - закрытие клапанов */
  switch (type) {
    case 1:
      if (key == "FL_UP" ) {
        Serial.println("FL_UP OPEN");
        pump_wheel_btn(FL_UP);
      } else if (key == "FL_DOWN" ) {
        Serial.println("FL_DOWN OPEN");
        pump_out_wheel_btn(FL_DOWN);
      } else if (key == "FR_UP" ) {
        Serial.println("FR_UP OPEN");
        pump_wheel_btn(FR_UP);
      } else if (key == "FR_DOWN" ) {
        Serial.println("FR_DOWN OPEN");
        pump_out_wheel_btn(FR_DOWN);
      } else if (key == "RL_UP" ) {
        Serial.println("RL_UP OPEN");
        pump_wheel_btn(RL_UP);
      } else if (key == "RL_DOWN" ) {
        Serial.println("RL_DOWN OPEN");
        pump_out_wheel_btn(RL_DOWN);
      } else if (key == "RR_UP" ) {
        Serial.println("RR_UP OPEN");
        pump_wheel_btn(RR_UP);
      } else if (key == "RR_DOWN" ) {
        Serial.println("RR_DOWN OPEN");
        pump_out_wheel_btn(RR_DOWN);
      } else if (key == "LEFT_UP" ) {
        Serial.println("LEFT_UP OPEN");
        left_car("UP", 1);
      } else if (key == "LEFT_DOWN" ) {
        Serial.println("LEFT_DOWN OPEN");
        left_car("DOWN", 1);
      } else if (key == "RIGHT_UP" ) {
        Serial.println("RIGHT_UP OPEN");
        right_car("UP", 1);
      } else if (key == "RIGHT_DOWN" ) {
        Serial.println("RIGHT_DOWN OPEN");
        right_car("DOWN", 1);
      } else if (key == "ALL_UP" ) {
        Serial.println("ALL_UP OPEN");
        all_car("UP", 1);
      } else if (key == "ALL_DOWN" ) {
        Serial.println("ALL_DOWN OPEN");
        all_car("DOWN", 1);
      } else if (key == "FRONT_UP" ) {
        Serial.println("FRONT_UP OPEN");//ТУТ
        front_car("UP", 1);
      } else if (key == "FRONT_DOWN" ) {
        Serial.println("FRONT_DOWN OPEN");
        front_car("DOWN", 1);
      } else if (key == "REAR_UP" ) {
        Serial.println("REAR_UP OPEN");//ТУТ
        rear_car("UP", 1);
      } else if (key == "REAR_DOWN" ) {
        Serial.println("REAR_DOWN OPEN");
        rear_car("DOWN", 1);
      }
      break;
    case 0:
      if (key == "FL_UP" ) {
        Serial.println("ПЕРЕДНЕЕ ЛЕВОЕ НАКАЧКА ЗАКРЫТО");
        valve_closing_btn(FL_UP);
        upd_wheel_bd("FL");
      } else if (key == "FL_DOWN" ) {
        Serial.println("ПЕРЕДНЕЕ ЛЕВОЕ ОТКАЧКА ЗАКРЫТО");
        valve_closing_btn(FL_DOWN);
        upd_wheel_bd("FL");
      } else if (key == "FR_UP" ) {
        Serial.println("ПЕРЕДНЕЕ ПРАВОЕ НАКАЧКА ЗАКРЫТО");
        valve_closing_btn(FR_UP);
        upd_wheel_bd( "FR");
      } else if (key == "FR_DOWN" ) {
        Serial.println("ПЕРЕДНЕЕ ПРАВОЕ ОТКАЧКА ЗАКРЫТО");
        valve_closing_btn(FR_DOWN);
        upd_wheel_bd( "FR");
      } else if (key == "RL_UP" ) {
        Serial.println("ЗАДНЕЕ ЛЕВОЕ НАКАЧКА ЗАКРЫТО");
        valve_closing_btn(RL_UP);
        upd_wheel_bd( "RL");
      } else if (key == "RL_DOWN" ) {
        Serial.println("ЗАДНЕЕ ЛЕВОЕ ОТКАЧКА ЗАКРЫТО");
        valve_closing_btn(RL_DOWN);
        upd_wheel_bd( "RL");
      } else if (key == "RR_UP" ) {
        Serial.println("ЗАДНЕЕ ПРАВОЕ НАКАЧКА ЗАКРЫТО");
        valve_closing_btn(RR_UP);
        upd_wheel_bd( "RR");
      } else if (key == "RR_DOWN" ) {
        Serial.println("ЗАДНЕЕ ПРАВОЕ ОТКАЧКА ЗАКРЫТО");
        valve_closing_btn(RR_DOWN);
        upd_wheel_bd( "RR");
      } else if (key == "LEFT_UP" ) {
        Serial.println("ЛЕВО НАКАЧКА ЗАКРЫТО");
        left_car("UP", 0);
      } else if (key == "LEFT_DOWN" ) {
        Serial.println("ЛЕВО ОТКАЧКА ЗАКРЫТО");
        left_car("DOWN", 0);
      } else if (key == "RIGHT_UP" ) {
        Serial.println("ПРАВО НАКАЧКА ЗАКРЫТО");
        right_car("UP", 0);
      } else if (key == "RIGHT_DOWN" ) {
        Serial.println("ПРВАО ОТКАЧКА ЗАКРЫТО");
        right_car("DOWN", 0);
      } else if (key == "ALL_UP" ) {
        Serial.println("ВСЯ НАКАЧКА ЗАКРЫТО");
        all_car("UP", 0);
      } else if (key == "ALL_DOWN" ) {
        Serial.println("ВСЯ ОТКАЧКА ЗАКРЫТО");
        all_car("DOWN", 0);
      } else if (key == "FRONT_UP" ) {
        Serial.println("ПЕРЕД НАКАЧКА ЗАКРЫТО");//ТУТ
        front_car("UP", 0);
      } else if (key == "FRONT_DOWN" ) {
        Serial.println("ПЕРЕД ОТКАЧКА ЗАКРЫТО");
        front_car("DOWN", 0);
      } else if (key == "REAR_UP" ) {
        Serial.println("ЗАД НАКАЧКА ЗАКРЫТО");//ТУТ
        rear_car("UP", 0);
      } else if (key == "REAR_DOWN" ) {
        Serial.println("ЗАД ОТКАЧКА ЗАКРЫТО");
        rear_car("DOWN", 0);
      }
      break;
  }
}


/** РАБОТА С БД */

void upd_wheel_bd(String wheel) {
  EEPROM.get(0, barwheels);

  barwheels.FL = barwheels.FL;
  barwheels.FR = barwheels.FR;
  barwheels.RL = barwheels.RL;
  barwheels.RR = barwheels.RR;

  if (wheel == "ALL") {
    barwheels.FL = get_pressure(Sensor_FL);
    barwheels.FR = get_pressure(Sensor_FR);
    barwheels.RL = get_pressure(Sensor_RL);
    barwheels.RR = get_pressure(Sensor_RR);
  } else if (wheel == "LEFT") {
    barwheels.FL = get_pressure(Sensor_FL);
    barwheels.RL = get_pressure(Sensor_RL);
  } else if (wheel == "RIGHT") {
    barwheels.FR = get_pressure(Sensor_FR);
    barwheels.RR = get_pressure(Sensor_RR);
  } else if (wheel == "FRONT") {
    barwheels.FL = get_pressure(Sensor_FL);
    barwheels.FR = get_pressure(Sensor_FR);
  } else if (wheel == "REAR") {
    barwheels.RL = get_pressure(Sensor_RL);
    barwheels.RR = get_pressure(Sensor_RR);
  } else if (wheel == "FL") {
    barwheels.FL = get_pressure(Sensor_FL);
  } else  if (wheel == "FR") {
    barwheels.FR =  get_pressure(Sensor_FR);
  } else  if (wheel == "RL") {
    barwheels.RL =  get_pressure(Sensor_RL);
  } else  if (wheel == "RR") {
    barwheels.RR =  get_pressure(Sensor_RR);
  }

  EEPROM.put(0, barwheels);
  print_bd();
}

float read_wheel_bd(String wheel) {

  EEPROM.get(0,barwheels);

  if (wheel == "FL") {
    return barwheels.FL;
  } else  if (wheel == "FR") {
    return barwheels.FR;
  } else  if (wheel == "RL") {
    return barwheels.RL;
  } else  if (wheel == "RR") {
    return barwheels.RR;
  }
}


/** ФУНКЦИИ ПОЛУЧЕНИЯ ДАВЛЕНИЯ  */

/** Функция перевода давления в бары */
float funcBar(float val) {
  float vin = (val * 0.004887);
  float pressure = 3.0 * (vin - 0.475);
  float pressure_bar = pressure;
  return pressure_bar;
}

/** Получение давления с датчика по колесу */
float get_pressure(int sensor_pin) {
  int voltage = analogRead(sensor_pin);
  float pressure_bar = funcBar(voltage);
  return pressure_bar;
}

/** МЕСТО ДЛЯ ФУНКЦИИ ПОЛУЧЕНИЯ ДАВЛЕНИЯ И ПЕРЕДАЧИ НА МОБИЛКУ */


/** ФУНКИИИ ДЛЯ УПРАВЛЕНИЯ КОЛЕСАМИ  */

/** Накачка подушки полеса */
void pump_wheel(int wheel, float good_bar, int sensor_pin) {
  Serial.println("PUMP_WHEEL FUNC");
  Serial.print("КЛАПАН  ");
  Serial.print(wheel);
  Serial.println("");
  float bar = get_pressure(sensor_pin);
  int ddd = 1;
  while (bar != good_bar) {

    mosfet.digitalWrite(wheel, HIGH);
    bar = get_pressure(sensor_pin);
      if (bar > good_bar || bar == good_bar) {
      bar = good_bar;
    }
  }
  if (bar == good_bar) {
    Serial.println("НАКАЧКА ЗАКРЫТО ");
    mosfet.digitalWrite(wheel, LOW);
  }
}

/** Спуск подушки колеса */
void descent_wheel(int wheel, float good_bar, int sensor_pin) {
  Serial.print("КЛАПАН  ");
  Serial.print(wheel);
  Serial.println("");
  float bar = get_pressure(sensor_pin);
  int ddd = 1;
  while (bar != good_bar) {
    mosfet.digitalWrite(wheel, HIGH);
    bar = get_pressure(sensor_pin);
    if (bar < good_bar || bar == good_bar) {
      bar = good_bar;
    }
  }
  if (bar == good_bar) {
    Serial.println("ОТКАЧКА ЗАКРЫТО ");
    mosfet.digitalWrite(wheel, LOW);
  }
}

/** Стабилизация давления */
void check_wheels() {
  Serial.println("STABIL");
  int sensor_pins[] = {Sensor_FL, Sensor_FR, Sensor_RL, Sensor_RR};
  int valve_up[] = {FL_UP, FR_UP, RL_UP, RR_UP};
  int valve_down[] = {FL_DOWN, FR_DOWN, RL_DOWN, RR_DOWN};
  String bd_key[] = {"FL", "FR", "RL", "RR"};
  for (int i = 0; i < 4; i++) {
    float bar_bd = read_wheel_bd(bd_key[i]);// Запрос к бд (СДЕЛАТЬ!!!)
    float current_bar = get_pressure(sensor_pins[i]);
    Serial.println("#: ");
    Serial.println(i);

    valve_closing_btn(valve_down[i]);
    if (bar_bd > current_bar) {
      pump_wheel(valve_up[i], bar_bd, sensor_pins[i]);
    } else if (bar_bd < current_bar) {
      descent_wheel(valve_up[i], bar_bd, sensor_pins[i]);
    }
  }
}

void pump_wheel_btn(int wheel) {
  mosfet.digitalWrite(wheel, HIGH);
}

void pump_out_wheel_btn(int wheel) {
  mosfet.digitalWrite(wheel, HIGH);
}

void valve_closing_btn(int wheel) {
  mosfet.digitalWrite(wheel, LOW);
}

void all_car(String type, int type_valve) {
  switch (type_valve) {
    case 1:
      if (type == "UP") {
        pump_wheel_btn(FL_UP);
        pump_wheel_btn(FR_UP);
        pump_wheel_btn(RL_UP);
        pump_wheel_btn(RR_UP);
      } else if (type == "DOWN") {
        pump_out_wheel_btn(FL_DOWN);
        pump_out_wheel_btn(FR_DOWN);
        pump_out_wheel_btn(RL_DOWN);
        pump_out_wheel_btn(RR_DOWN);
      }
      break;
    case 0:
      if (type == "UP") {
        valve_closing_btn(FL_UP);
        valve_closing_btn(FR_UP);
        valve_closing_btn(RL_UP);
        valve_closing_btn(RR_UP);
      } else if (type == "DOWN") {
        valve_closing_btn(FL_DOWN);
        valve_closing_btn(FR_DOWN);
        valve_closing_btn(RL_DOWN);
        valve_closing_btn(RR_DOWN);
      }
      break;
  }
  upd_wheel_bd("ALL");

}

void left_car(String type, int type_valve) {
  switch (type_valve) {
    case 1:
      if (type == "UP") {
        pump_wheel_btn(FL_UP);
        pump_wheel_btn(RL_UP);
      } else if (type == "DOWN") {
        pump_out_wheel_btn(FL_DOWN);
        pump_out_wheel_btn(RL_DOWN);
      }
      break;
    case 0:
      if (type == "UP") {
        valve_closing_btn(FL_UP);
        valve_closing_btn(RL_UP);
      } else if (type == "DOWN") {
        valve_closing_btn(FL_DOWN);
        valve_closing_btn(RL_DOWN);
      }
      break;
  }
  upd_wheel_bd("LEFT");
}

void right_car(String type, int type_valve) {
  switch (type_valve) {
    case 1:
      if (type == "UP") {
        pump_wheel_btn(FR_UP);
        pump_wheel_btn(RR_UP);
      } else if (type == "DOWN") {
        pump_out_wheel_btn(FR_DOWN);
        pump_out_wheel_btn(RR_DOWN);
      }
      break;
    case 0:
      if (type == "UP") {
        valve_closing_btn(FR_UP);
        valve_closing_btn(RR_UP);
      } else if (type == "DOWN") {
        valve_closing_btn(FR_DOWN);
        valve_closing_btn(RR_DOWN);
      }
      break;
  }
  upd_wheel_bd("RIGHT");
}

void front_car(String type, int type_valve) {
  switch (type_valve) {
    case 1:
      if (type == "UP") {
        pump_wheel_btn(FL_UP);
        pump_wheel_btn(FR_UP);
      } else if (type == "DOWN") {
        pump_out_wheel_btn(FL_DOWN);
        pump_out_wheel_btn(FR_DOWN);
      }
      break;
    case 0:
      if (type == "UP") {
        valve_closing_btn(FL_UP);
        valve_closing_btn(FR_UP);
      } else if (type == "DOWN") {
        valve_closing_btn(FL_DOWN);
        valve_closing_btn(FR_DOWN);
      }
      break;
  }
  upd_wheel_bd("FRONT");

}

void rear_car(String type, int type_valve) {
  switch (type_valve) {
    case 1:
      if (type == "UP") {
        pump_wheel_btn(RL_UP);
        pump_wheel_btn(RR_UP);
      } else if (type == "DOWN") {
        pump_out_wheel_btn(RL_DOWN);
        pump_out_wheel_btn(RR_DOWN);
      }
      break;
    case 0:
      if (type == "UP") {
        valve_closing_btn(RL_UP);
        valve_closing_btn(RR_UP);
      } else if (type == "DOWN") {
        valve_closing_btn(RL_DOWN);
        valve_closing_btn(RR_DOWN);
      }
      break;
  }
upd_wheel_bd("REAR");
}
