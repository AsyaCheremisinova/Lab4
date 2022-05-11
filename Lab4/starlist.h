#ifndef STARLIST_H
#define STARLIST_H
#include <QAbstractListModel>
#include <QVariant>
#include <QList>
#include <QModelIndex>
#include <QItemSelectionModel>
#include <QStringListModel>
#include <QtSql/QSqlDatabase>
#include <QtSql/QSqlQueryModel>
#include <QDebug>
#include <QtSql/QSqlQuery>
#include <QtSql>

class StarList : public QSqlQueryModel
{
    Q_OBJECT
    Q_PROPERTY(QSqlQueryModel* starModel READ getModel CONSTANT)
    Q_PROPERTY(bool IsConnectionOpen READ isConnectionOpen CONSTANT)

private:
    QSqlDatabase db;
    const static char* SQL_SELECT;
    QSqlQueryModel *getModel();
    bool _isConnectionOpen;
    bool isConnectionOpen();
public:
    explicit StarList(QObject* parent);

    void refresh();
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void add(const QString& Name, const QString& Constellation, const int ApparentMagnitude, const QString& DistanceFromEarth, const QString& Coordinates);
    Q_INVOKABLE void edit(const QString& Name, const QString& Constellation, const int ApparentMagnitude, const QString& DistanceFromEarth, const QString& Coordinates,const int index);
    Q_INVOKABLE void remove(const int index);
    Q_INVOKABLE QString find(const QString count);
    //Q_INVOKABLE QString getCount(const QString breed);
};

#endif // STARLIST_H
