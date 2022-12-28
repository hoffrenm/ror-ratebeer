const BREWERIES = {};

BREWERIES.show = () => {
  document.querySelectorAll(".tablerow").forEach((el) => el.remove());
  const table = document.getElementById("brewerytable");

  BREWERIES.list.forEach((brewery) => {
    const tr = createTableRow(brewery);
    table.appendChild(tr);
  });
};

BREWERIES.reverse = () => {
  BREWERIES.list.reverse();
};

BREWERIES.sortByName = () => {
  BREWERIES.list.sort((a, b) => {
    return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
  });
};

BREWERIES.sortByYear = () => {
  BREWERIES.list.sort((a, b) => {
    return a.year > b.year;
  });
};

BREWERIES.sortByAmountOfBeers = () => {
  BREWERIES.list.sort((a, b) => {
    return a.beers.length > b.beers.length;
  });
};

BREWERIES.sortByActive = () => {
  BREWERIES.list.sort((a, b) => {
    return a.active > b.active
  });
};

const breweries = () => {
  if (document.querySelectorAll("#brewerytable").length < 1) return;


  document.getElementById("reverse").addEventListener("click", (e) => {
    e.preventDefault();
    BREWERIES.reverse();
    BREWERIES.show();
  });

  document.getElementById("name").addEventListener("click", (e) => {
    e.preventDefault;
    BREWERIES.sortByName();
    BREWERIES.show();
  });

  document.getElementById("year").addEventListener("click", (e) => {
    e.preventDefault;
    BREWERIES.sortByYear();
    BREWERIES.show();
  });

  document.getElementById("beerquantity").addEventListener("click", (e) => {
    e.preventDefault;
    BREWERIES.sortByAmountOfBeers();
    BREWERIES.show();
  });

  document.getElementById("active").addEventListener("click", (e) => {
    e.preventDefault;
    BREWERIES.sortByActive();
    BREWERIES.show();
  });
  
  fetch("breweries.json")
    .then((response) => response.json())
    .then(handleResponse);
};

const handleResponse = (breweries) => {
  BREWERIES.list = breweries;
  BREWERIES.sortByName();
  BREWERIES.show();
};

const createTableRow = (brewery) => {
  const tr = document.createElement("tr");
  tr.classList.add("tablerow");
  const breweryname = tr.appendChild(document.createElement("td"));
  breweryname.innerHTML = brewery.name;
  const year = tr.appendChild(document.createElement("td"));
  year.innerHTML = brewery.year;
  const beerquantity = tr.appendChild(document.createElement("td"));
  beerquantity.innerHTML = brewery.beers.length;
  const active = tr.appendChild(document.createElement("td"));
  active.innerHTML = brewery.active;

  return tr;
};

export { breweries };
