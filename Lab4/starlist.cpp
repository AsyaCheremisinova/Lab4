#include "starlist.h"
#include <QDebug>
#include "QStringList"
#include "QStringListModel"
#include "QString"

StarList::StarList(QObject *parent) : QSqlQueryModel(parent)
{
    db = QSqlDatabase::addDatabase("QPSQL", "myConnection");
    db.setDatabaseName("Star");
    db.setUserName("postgres");
    db.setPort(5432);
    db.setHostName("localhost");
    db.setPassword("Asya130401");
    _isConnectionOpen = db.open();

    if(_isConnectionOpen){
        qDebug() << "bd is open";
    }
    else {
        qDebug() << "bd is CLOSED";
    }

    QString m_schema = QString( "CREATE TABLE IF NOT EXISTS STAR"
                                "(id SERIAL PRIMARY KEY, name Text, owner Text, age Integer, breed Text);" );
    QSqlQuery qry(m_schema, db);

    refresh();
}

QSqlQueryModel* StarList::getModel()
{
    return this;
}
void StarList::refresh()
{
    this->setQuery(StarList::SQL_SELECT,db);
}
bool StarList::isConnectionOpen()
{
    return _isConnectionOpen;
}
const char* StarList::SQL_SELECT = "SELECT name, constellation, apparentMagnitude, distanceFromEarth, coordinates, id FROM star";

QVariant StarList::data(const QModelIndex &index, int role) const
{
    QVariant value = QSqlQueryModel::data(index, role);
    if(role < Qt::UserRole - 1)
    {
        value = QSqlQueryModel::data(index, role);
    }
    else
    {
        int columnIdx = role - Qt::UserRole - 1;
        QModelIndex modelIndex = this->index(index.row(), columnIdx);
        value = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
    }
    return value;
}

QHash<int, QByteArray> StarList::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::UserRole + 1] = "nameOfStar";
    roles[Qt::UserRole + 2] = "constellationOfStar";
    roles[Qt::UserRole + 3] = "apparentMagnitudeOfStar";
    roles[Qt::UserRole + 4] = "distanceOfStar";
    roles[Qt::UserRole + 5] = "coordinatesOfStar";
    roles[Qt::UserRole + 6] = "StarID";
    return roles;
}

void StarList::add(const QString& Name, const QString& Constellation, const int ApparentMagnitude, const QString& DistanceFromEarth, const QString& Coordinates)
{
    QSqlQuery query(db);
    QString pg_query = QString("INSERT INTO star (name, constellation, apparentMagnitude, distanceFromEarth, coordinates) VALUES ('%1', '%2', %3, '%4', '%5')")
            .arg(Name).arg(Constellation).arg(ApparentMagnitude).arg(DistanceFromEarth).arg(Coordinates);
    query.exec(pg_query);
    refresh();
}
void StarList::edit(const QString& Name, const QString& Constellation, const int ApparentMagnitude, const QString& DistanceFromEarth, const QString& Coordinates, const int id)
{
    QSqlQuery query(db);
    QString pg_query = QString("UPDATE star SET name = '%1', constellation = '%2', apparentMagnitude = %3, distanceFromEarth = '%4', coordinates = '%5'"
                               "WHERE id = %5")
            .arg(Name).arg(Constellation).arg(ApparentMagnitude).arg(DistanceFromEarth).arg(Coordinates).arg(id);
    query.exec(pg_query);
    refresh();
}
void StarList::remove(const int index)
{
    QSqlQuery query(db);
    QString strQuery= QString("DELETE FROM star WHERE id = %1")
            .arg(index);
    query.exec(strQuery);

    refresh();
}
QString StarList::find(const QString count)
{
    QSqlQuery query(db);
    QString strQuery= QString("SELECT COUNT(id) FROM star WHERE ApparentMagnitude = '%1'")
                .arg(count);
    query.exec(strQuery);
    QString kol = 0;
    while (query.next())
    {
        kol = query.value(0).toString();
         qDebug() << kol;
    }
    return (kol);
}
