class Shop {
  constructor(id, name) {
    this.id = id;
    this.name = name;
  }
}

class Order {
  constructor(shopId, amount, month, fulfilled) {
    this.shopId = shopId;
    this.amount = amount;
    this.month = month;
    this.fulfilled = fulfilled;
  }
}

const allShops = [
  new Shop(1, "Atlantis"),
  new Shop(2, "Rustic Range"),
  new Shop(3, "Golden Apple"),
  new Shop(4, "Cascade Corner"),
];

const allOrders = [
  new Order(1, 230, 5, true),
  new Order(1, 145, 5, true),
  new Order(1, 600, 6, false),
  new Order(2, 55, 5, true),
  new Order(2, 39, 6, false),
  new Order(3, 180, 5, true),
  new Order(3, 490, 5, true),
  new Order(3, 1250, 5, true),
  new Order(3, 480, 6, true),
  new Order(3, 535, 6, false),
  new Order(3, 499, 6, false),
  new Order(4, 300, 5, true),
  new Order(4, 275, 5, true),
  new Order(4, 35, 6, false),
  new Order(4, 79, 6, false),
];
// Your employer has multiple shops with associated orders.
// In order to get better insights into their sales operations
// you have been tasked with getting some reporting statistics
// from their sales data.

// See class definitions above for data structure.

// 1a. Display the names of the shops
(function shopNames() {
  allShops.forEach((shop) => console.log(shop.name));
})();

// 1b. Display the sum of the shop's fulfilled orders after the name
function shopNamesAndFulfilledOrders(orders, shops) {
  const nameSum =shops.map((shop) => {
    const name = shop.name;
    const fulfilledOrders = orders.filter(
      (order) => order.shopId === shop.id
    );
    const sum = fulfilledOrders
      .map((order) => order.amount)
      .reduce((curr, el) => curr + el);
    return {name, sum}
  });

  return nameSum
}
console.log(shopNamesAndFulfilledOrders(allOrders, allShops));

// 2. Display the name of the shop that has the largest unfulfilled order
function largestUnfulfilled(orders, shops) {
  const unfulfilled = orders.filter((order) => !order.fulfilled);
  const largestUnfulfilled = unfulfilled.reduce((prev, current) => {
    return prev.amount > current.amount ? prev : current;
  });
  const shop = shops.find((shop) => shop.id === largestUnfulfilled.shopId)
  return shop.name
}

console.log( largestUnfulfilled(allOrders, allShops));

// 3. Display the name of the shop that had the least orders in May
const frequencyCounter = function (arr) {
  const map = arr.reduce(
    (acc, e) => acc.set(e.shopId, (acc.get(e.shopId) || 0) + 1),
    new Map()
  );
  return map;
};

const leastOrders = (orders, shops) => {
  const map = frequencyCounter(orders);

  const minId = [...map.keys()].reduce((a, b) =>
  map.get(a) < map.get(b) ? a : b
  );

  const target = shops.find((shop)=>shop.id === minId)
  return target.name;
};

console.log(leastOrders(allOrders, allShops));
// Put your code here
