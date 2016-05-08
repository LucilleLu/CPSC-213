#include <stdlib.h>
#include <stdio.h>
#include <string.h>

/*
 * Class Person
 */

struct Person_class {
    void* super;
    void (* toString) (void*, char*, int);
};


struct Person {
    struct Person_class* class;
    char* name;
};

void Person_toString (void* thisVP, char* buf, int bufSize) {
    struct Person* this = thisVP;
    snprintf (buf, bufSize, "%s %s", "Name:", this->name);
}


struct Person_class Person_class_obj = {NULL, Person_toString};

struct Person* new_Person(char* name) {
    struct Person* obj = malloc (sizeof (struct Person));
    obj->class = &Person_class_obj;
    obj->name = strdup(name); 
    return obj;
}


/*
 * Class Student extends Person
 */

struct Student_class {
    struct Person_class* super;
    void (* toString) (void*, char*, int);
};

struct Student {
    struct Student_class* class;
    char* name;
    int sid;
};

void Student_toString (void* thisVP, char* buf, int bufSize) {
    struct Student* this = thisVP;
    this->class->super->toString (this, buf, bufSize);
    snprintf(buf, bufSize, "%s, SID: %d", strdup(buf), this->sid);
    //return snprintf (buf, bufSize, "%s %d", ", SID: ", this->sid);
}

struct Student_class Student_class_obj = {&Person_class_obj, Student_toString};

struct Student* new_Student(char* name, int sid) {
    struct Student* obj = malloc (sizeof (struct Student));
    obj->class = &Student_class_obj;
    obj->name = strdup(name);
    obj->sid = sid;
    return obj;
}

/*
 * Main
 */

void print(void* person){
    struct Person* p = person;
        char buf [1000];
        p->class->toString(p, buf, sizeof(buf));
        printf("%s\n", buf);
}

int main (int argc, char** argv) {
    void* person[2] = {new_Person("Alex"), new_Student ("Alice", 300)};
    for (int i = 0; i < 2 ; i++) {
        print(person[i]);
    }
}




