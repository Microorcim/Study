#include <iostream>
#include <vector>
#include <cstring>
#include <fstream>
#include <Windows.h>

class letter {
private:
    char* adr1;
    char* fam1;
    char* name1;
    char* adr2;
    char* fam2;
    char* name2;
    double cost;

public:
    inline static int count = 0;

    letter(const char* _adr1, const char* _fam1, const char* _name1,
           const char* _adr2, const char* _fam2, const char* _name2, double _cost)
            : cost(_cost) {
        adr1 = new char[strlen(_adr1) + 1];
        strcpy(adr1, _adr1);
        fam1 = new char[strlen(_fam1) + 1];
        strcpy(fam1, _fam1);
        name1 = new char[strlen(_name1) + 1];
        strcpy(name1, _name1);
        adr2 = new char[strlen(_adr2) + 1];
        strcpy(adr2, _adr2);
        fam2 = new char[strlen(_fam2) + 1];
        strcpy(fam2, _fam2);
        name2 = new char[strlen(_name2) + 1];
        strcpy(name2, _name2);
        count++;
    }

    ~letter() {
        delete[] adr1;
        delete[] fam1;
        delete[] name1;
        delete[] adr2;
        delete[] fam2;
        delete[] name2;
        count--;
    }

    void print() const {
        std::cout << "| " << fam1 << " " << name1 << " | " << adr1
                  << " | " << fam2 << " " << name2 << " | " << adr2
                  << " | " << cost << " |" << std::endl;
    }

    void saveToFile(std::ofstream& file) const {
        file << fam1 << "," << name1 << "," << adr1 << ","
             << fam2 << "," << name2 << "," << adr2 << "," << cost << std::endl;
    }

    std::string getFam2() const { return fam2; }
    std::string getName2() const { return name2; }
    double getCost() const { return cost; }
    int getCount() const {return count;}

};

class Dialog {
    std::vector<letter> arrLetters;

public:
    Dialog() {
        loadFromFile();
    }

    void start() {

        int choice;
        while (true) {
            std::cout << "\nВыберите действие:" << std::endl;
            std::cout << "1. Добавить новый элемент в базу" << std::endl;
            std::cout << "2. Распечатка данных в табличном виде" << std::endl;
            std::cout << "3. Поиск письма по фамилии и имени" << std::endl;
            std::cout << "4. Найти все письма со стоимостью более заданного значения" << std::endl;
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
                    addElement();
                    break;
                case 2:
                    print();
                    break;
                case 3:
                    findSender();
                    break;
                case 4:
                    findMoreExpensive();
                    break;
                case 0:
                    saveToFile();
                    std::cout << "Выход из программы." << std::endl;
                    return;
                default:
                    std::cout << "Некорректный выбор, попробуйте снова." << std::endl;
            }
        }
    }

private:
    void addElement() {
        char adr1[100], fam1[50], name1[50];
        char adr2[100], fam2[50], name2[50];
        double cost;

        std::cout << "Введите адрес получателя: ";
        std::cin.ignore();
        std::cin.getline(adr1, 100);
        std::cout << "Введите фамилию получателя: ";
        std::cin.getline(fam1, 50);
        std::cout << "Введите имя получателя: ";
        std::cin.getline(name1, 50);
        std::cout << "Введите адрес отправителя: ";
        std::cin.getline(adr2, 100);
        std::cout << "Введите фамилию отправителя: ";
        std::cin.getline(fam2, 50);
        std::cout << "Введите имя отправителя: ";
        std::cin.getline(name2, 50);
        std::cout << "Введите стоимость письма: ";
        std::cin >> cost;
        arrLetters.emplace_back(adr1, fam1, name1, adr2, fam2, name2, cost);
        std::cout << "Письмо успешно добавлено!" << std::endl;
    }

    void print() {
        std::cout << "| Получатель | Адрес Получателя | Отправитель | Адрес Отправителя | Стоимость |" << std::endl;
        std::cout << "--------------------------------------------------------------------------------" << std::endl;
        for (const auto& letter : arrLetters) {
            letter.print();
        }
    }

    void saveToFile() {
        std::ofstream file("letters.txt");
        if (!file) {
            std::cout << "Ошибка открытия файла!" << std::endl;
            return;
        }
        for (const auto& letter : arrLetters) {
            letter.saveToFile(file);
        }
        file.close();
        std::cout << "Данные успешно сохранены в letters.txt" << std::endl;
    }

    void loadFromFile() {
        std::ifstream file("letters.txt");
        if (!file) return;

        char adr1[100], fam1[50], name1[50];
        char adr2[100], fam2[50], name2[50];
        double cost;

        while (file.getline(fam1, 50, ',') &&
               file.getline(name1, 50, ',') &&
               file.getline(adr1, 100, ',') &&
               file.getline(fam2, 50, ',') &&
               file.getline(name2, 50, ',') &&
               file.getline(adr2, 100, ',') &&
               file >> cost) {
            file.ignore();
            arrLetters.emplace_back(adr1, fam1, name1, adr2, fam2, name2, cost);
        }
        file.close();
    }

    void findSender() {
        std::string fam;
        std::string name;
        std::cout << "Введите фамилию отправителя: ";
        std::cin >> fam;
        std::cout << "Введите имя отправителя: ";
        std::cin >> name;

        for (const auto& letter : arrLetters) {
            if (letter.getFam2() == fam && letter.getName2() == name) {
                letter.print();
                break;
            }
        }
    }

    void findMoreExpensive() {
        double minCost;
        std::cout << "Введите стоимость: ";
        std::cin >> minCost;
        if (std::cin.fail()) {
            std::cin.clear();
            std::cin.ignore(10000, '\n');
            std::cout << "Ошибка ввода! Введите число.\n";
            return;
        }
        for (const auto& letter : arrLetters) {
            if (letter.getCost() > minCost) {
                letter.print();
            }
        }
    }

    int const getCount(){ return arrLetters.size();}

};

int main() {
    system("chcp 65001");
    SetConsoleCP(1251);
    Dialog d;
    d.start();
    return 0;
}
