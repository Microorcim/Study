#include <iostream>
#include <chrono>
#include <vector>

class Date {
private:
    std::chrono::system_clock::time_point date;

public:
    Date(int year, int month, int day) {
        std::tm tm = {};
        tm.tm_year = year - 1900; // std::tm хранит года начиная с 1900
        tm.tm_mon = month - 1;    // std::tm хранит месяцы от 0 до 11
        tm.tm_mday = day;

        date = std::chrono::system_clock::from_time_t(std::mktime(&tm));
    }

    void print() const {
        std::time_t tt = std::chrono::system_clock::to_time_t(date);
        std::cout << std::ctime(&tt);
    }
};


class Storage {
private:
    std::string name;
    double cost;
    int quantity;
    int num;
    Date expirationDate;
    static int count;
public:
    Storage(std::string _name, double _cost, int _quantity, int _num, date _expirationDate, int _count)
            : name(_name), cost(_cost), quantity(_quantity), num(_num), expirationDate(_expirationDate), count(_count) {}

    void saveToFile(std::ofstream& file) const {
        file << name << ","
             << cost << ","
             << quantity << ","
             << num << ","
             << expirationDate << ","  //  Мб ошибка будет ХЗ
             << count << std::endl;
    }

};

class Storages {
private:
    vector<Storage> arrStorages;

    Storages {
        loadFromFile();
    };

    void loadFromFile() {
        std::ifstream file("storages.txt");
        if (!file.is_open()) {
            std::cerr << "Не удалось открыть файл storages.txt" << std::endl;
            return;
        }

        std::string line;
        // Читаем файл построчно (каждая строка соответствует одному объекту Storage)
        while (std::getline(file, line)) {
            if (line.empty())
                continue; // пропускаем пустые строки

            std::istringstream iss(line);
            std::string token;

            // Читаем поле name
            std::string name;
            if (!std::getline(iss, name, ',')) continue;

            // Читаем поле cost (как строку, затем преобразуем)
            std::string costStr;
            if (!std::getline(iss, costStr, ',')) continue;
            double cost = std::stod(costStr);

            // Читаем поле quantity
            std::string quantityStr;
            if (!std::getline(iss, quantityStr, ',')) continue;
            int quantity = std::stoi(quantityStr);

            // Читаем поле num
            std::string numStr;
            if (!std::getline(iss, numStr, ',')) continue;
            int num = std::stoi(numStr);

            // Читаем оставшуюся часть строки как expirationDate
            std::string dateStr;
            if (!std::getline(iss, dateStr))
                continue;
            // Создаём объект Date (предполагается, что такой конструктор существует)
            Date expirationDate(dateStr);

            // Создаём объект Storage и добавляем его в вектор
            // Здесь передаём Storage::count как _count, либо можно передать любое нужное значение
            storages.emplace_back(name, cost, quantity, num, expirationDate, Storage::count);
        }
        file.close();
    }

    void saveToFile() {
        std::ofstream file("storages.txt");
        if (!file) {
            std::cout << "Ошибка открытия файла!" << std::endl;
            return;
        }

        for (const auto& storage : arrStorages) {
            storage.saveToFile(file);
        }

        file.close();
        std::cout << "Данные успешно сохранены в letters.txt" << std::endl;
    }
};

class Dialog {

    Dialog() {
        Storages storages;
    }

    void start() {
        int choice;
        while (true) {
            std::cout << "\nВыберите действие:" << std::endl;
            std::cout << "1. Добавить новый элемент в базу" << std::endl;
            std::cout << "2. Распечатка данных в табличном виде" << std::endl;
            std::cout << "3. Поиск товара по номеру секции" << std::endl;
            std::cout << "0. Выход из программы (сохранение данных)" << std::endl;
            std::cout << "Ваш выбор: ";
            std::cin >> choice;

            if (std::cin.fail()) {
                std::cin.clear();
                std::cin.ignore(10000, '\n');
                std::cout << "Ошибка ввода! Попробуйте снова." << std::endl;
                continue;
            }

            switch (choice) {
                case 1:
                    storages.
                    break;
                case 2:
                    break;

                case 0:
                    std::cout << "Выход из программы." << std::endl;
                    return;
                default:
                    std::cout << "Некорректный выбор, попробуйте снова." << std::endl;
            }
        }
    }
    }
};

int main() {
    std::cout << "KGFKFHG";
    return 0;
}