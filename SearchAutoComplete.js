const searchData = document.querySelector(".search");
const inputData = searchData.querySelector("input");
const dynamicBox = searchData.querySelector(".suggestions");
const localStorageValues = localStorage.getItem('inputData');
const dynamicBoxLength=5;

searchData.addEventListener('submit',(event)=>{
	event.preventDefault();
	const query = inputData.value.trim();

	window.location.href = "search.html?query="+inputData.value;

		if (query) {
			const timestamp = Date.now();
			const date = new Date(timestamp);
			const dateString = `${date.toLocaleDateString()} ${date.toLocaleTimeString()}`;

			const queryObject = {
			  text: query,
			  time: dateString
			};

			const queryHistory = JSON.parse(localStorage.getItem('queryHistory')) || [];
			const existingQueryIndex = queryHistory.findIndex(q => q.text === query);
			if (existingQueryIndex !== -1) {
			  queryHistory[existingQueryIndex].time = dateString;
			}else{
			queryHistory.push(queryObject);}
			localStorage.setItem('queryHistory', JSON.stringify(queryHistory));
		}
});
document.addEventListener('click',(event)=>{
  if (event.target !== inputData && event.target !== dynamicBox) {
	  searchData.classList.remove("active");
	  searchData.classList.remove("suggestions");
	  dynamicBox.innerHTML="";
	  dynamicBox.style.display='none';
  }
});
inputData.addEventListener('click', (e)=>{
	dynamicBox.innerHTML="";
	let dataUser = inputData.value;
	let dataSet = [];
	if (dataUser.length>0){
		dynamicBox.style.display='block';		  
		const queryHistory = JSON.parse(localStorage.getItem('queryHistory')) || [];
		const matchingSet = queryHistory.filter(q => {
		return q.text.toLocaleLowerCase().startsWith(dataUser.toLocaleLowerCase());
		});
		const matchingQueries = matchingSet.map(q => {
		return q.text;
		});
		const matchedQueries = queryLogData.filter( (data) => {
		return data.toLocaleLowerCase().startsWith(dataUser.toLocaleLowerCase());
		});
		dataSet = [...new Set([...matchingQueries, ...matchedQueries])];
		dataSet = dataSet.map((data) => {return data = '<li>' + data + '</li>';} );
		searchData.classList.add("active");
		dynamicSuggestions(dataSet);
		let dataListLoad = dynamicBox.querySelectorAll("li");
		for(let i=0; i< dynamicBoxLength;i++){
			dataListLoad[i].setAttribute("onclick","choose(this)");
		}
	}
	else{
		dynamicBox.style.display='block';		  
		const queryHistory = JSON.parse(localStorage.getItem('queryHistory')) || [];
		const matchingSet = queryHistory.filter(q => {
		return q.text.toLocaleLowerCase();
		});
		const matchingQueries = matchingSet.map(q => {
		return q.text;
		});
		dataSet=matchingQueries.reverse().map((data) => {return data = '<li>' + data + '</li>';} );
		searchData.classList.add("active");
		dynamicSuggestions(dataSet);
		let dataListLoad = dynamicBox.querySelectorAll("li");
		for(let i=0; i< dynamicBoxLength;i++){
			dataListLoad[i].setAttribute("onclick","choose(this)");
		}
	}
});
inputData.addEventListener('input',(e) => {
	dynamicBox.innerHTML="";
	let dataUser = inputData.value;
	let dataSet = [];
	if (dataUser.length>0){
		dynamicBox.style.display='block';		  
		const queryHistory = JSON.parse(localStorage.getItem('queryHistory')) || [];
		const matchingSet = queryHistory.filter(q => {
		return q.text.toLocaleLowerCase().startsWith(dataUser.toLocaleLowerCase());
		});
		const matchingQueries = matchingSet.map(q => {
		return q.text;
		});
		const matchedQueries = queryLogData.filter( (data) => {
		return data.toLocaleLowerCase().startsWith(dataUser.toLocaleLowerCase());
		});
		dataSet = [...new Set([...matchingQueries, ...matchedQueries])];
		dataSet = dataSet.map((data) => {return data = '<li>' + data + '</li>';} );
		searchData.classList.add("active");
		dynamicSuggestions(dataSet);
		let dataListLoad = dynamicBox.querySelectorAll("li");
		for(let i=0; i< dynamicBoxLength;i++){
			dataListLoad[i].setAttribute("onclick","choose(this)");
		}
	}
	else{
		searchData.classList.remove("active");
		searchData.classList.remove("suggestions");
		dynamicBox.innerHTML="";
		dynamicBox.style.display='none';
	}

});

function dynamicSuggestions(setData){
	let dataList ;
	if(!setData.length){
		value = inputData.value;
		dataList = '<li>'+ value+ '</li>';}
	else{dataList = setData.join('');}
	dynamicBox.innerHTML = dataList;

}

function choose(ele){
	let dataSelected = ele.textContent;
	inputData.value = dataSelected;
	searchData.querySelector("button").onclick;
	searchData.classList.remove("active");
	searchData.classList.remove("suggestions");
	dynamicBox.innerHTML="";
	window.location.href="search.html?query="+dataSelected;
	const query = dataSelected;

		if (query) {
			const timestamp = Date.now();
			const date = new Date(timestamp);
			const dateString = `${date.toLocaleDateString()} ${date.toLocaleTimeString()}`;
			const queryObject = {
			  text: query,
			  time: dateString
			};

			const queryHistory = JSON.parse(localStorage.getItem('queryHistory')) || [];
			const existingQueryIndex = queryHistory.findIndex(q => q.text === query);
			if (existingQueryIndex !== -1) {
			  queryHistory[existingQueryIndex].time = dateString;
			}else{
			queryHistory.push(queryObject);}
			localStorage.setItem('queryHistory', JSON.stringify(queryHistory));
		}
}

let activeIndex = -1;
inputData.addEventListener('keydown', (e) => {
	searchValue=inputData.value;
  const dataListLoad = dynamicBox.querySelectorAll("li");
  if (e.keyCode === 38) {
    e.preventDefault();
    activeIndex = (activeIndex - 1 + dataListLoad.length) % dataListLoad.length;
	highlightActive(dataListLoad,searchValue);
  } else if (e.keyCode === 40) {
    e.preventDefault();
    activeIndex = (activeIndex + 1) % dataListLoad.length;
    highlightActive(dataListLoad,searchValue);
  } else if (e.keyCode === 13) {
    e.preventDefault();
    if (activeIndex > -1) {
      choose(dataListLoad[activeIndex]);
      activeIndex = -1;
    }
	else {
      searchData.querySelector("button").click();
    }
  }
});

function highlightActive(dataListLoad,searchValue) {
	if(activeIndex <= -1 || activeIndex >dynamicBoxLength){
		inputData.value=searchValue;
	}
	else{
		for (let i = 0; i < dynamicBoxLength; i++) {
			if (i === activeIndex) {
			  dataListLoad[i].classList.add("active");
			  dataListLoad[i].classList.add("selected");
			  inputData.value = dataListLoad[i].textContent;
			} else {
			  dataListLoad[i].classList.remove("active");
			  dataListLoad[i].classList.remove("selected");
			}
		  }
	}
}
