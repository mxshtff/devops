## Чтобы распарсить JSON-объект:

```
cat demo.json | jq '.name'
"Google"
```

## Чтобы распарсить вложенный JSON-объект:

```
cat demo.json | jq '.location.city'
"Mountain View"
```

## Чтобы распарсить JSON-массив:

```
cat demo.json | jq '.employees[0].name'
"Michael"
```

## Чтобы извлечь конкретные поля из JSON-объекта:

```
cat demo.json | jq '.location | {street, city}'
{
  "city": "Mountain View",
  "street": "1600 Amphitheatre Parkway"
}
```