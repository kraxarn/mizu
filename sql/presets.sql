create table if not exists presets
(
    icon    text    not null,
    name    text    not null,
    amount  integer not null,
    type_id integer not null,
    foreign key (type_id) references drink_types (rowid)
)
