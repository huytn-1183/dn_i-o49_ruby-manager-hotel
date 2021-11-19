import React from "react"
import PropTypes from "prop-types"

function Filter(props) {
	const { params = {}, t = {}, attributes } = props
	const { search_params = {} } = params
	const {
		search_simple_cont = "",
		price_gt = "0",
		price_lt ="100",
		room_attributes_name_cont = ""
	} = search_params

	const [search, setSearch] = React.useState(search_simple_cont)
	const [attribute, setAttribute] = React.useState(room_attributes_name_cont)
	const [price, setPrice] = React.useState(Number(price_gt))

	const changeSearch = (event) => {
		setSearch(event.target.value)
	}
	const changePrice = (event) => {
		setPrice(Number(event.target.value))
	}
	const changeAttribute = (event) => {
		setAttribute(event.target.value)
	}
	const clickLabel = (label) => {
		setAttribute(label)
	}

	const denta = 50;
	const suggest = attributes.find(e => { const [label, value] = e; return label.match(new RegExp(attribute, "g")) }) || [];
	return(
		<section>
			<form className="row gy-3" id="room_search" action="/en/rooms" acceptCharset="UTF-8" method="get">
				<input type="hidden" readOnly name="search_params[price_lt]" value={price + denta} />
				<div className="col-12">
					<label htmlFor="search_params_search_simple_cont" className="form-label" >{t.simple_search}</label>
					<div className="input-group">
						<input className="form-control" type="search" name="search_params[search_simple_cont]" id="search_params_search_simple_cont" value={search} onChange={changeSearch} />
					</div>
				</div>

				<div className="col-12">
					<label htmlFor="search_params_room_attributes_name_cont" className="form-label" >{t.attribute_search}</label>
					<hr/>
					{attributes.map(_attribute => {
						const [label, value] = _attribute
						const light = "bg-light text-dark"
						const dark = "bg-dark"
						return <span key={value} className={"badge rounded-pill me-2 " + (label === attribute ? dark : light)} onClick={event => clickLabel(label)} >{label}</span>
					})}
					<hr/>
					<div className="input-group">
						<input className="form-control" type="hidden" name="search_params[room_attributes_name_cont]" id="search_params_room_attributes_name_cont" value={attribute} onChange={changeAttribute} />
					</div>
				</div>


				<div className="col-12">
					<div className="input-group">
						<label htmlFor="price-range" className="form-label">{t.price} {t.from}: {price}$ {t.to}: {price + denta}$</label>
						<input type="range" className="form-range" id="price-range" onChange={changePrice} name="search_params[price_gt]" value={price}/>
					</div>
				</div>
				<div className="col-12">
					<input type="submit" name="commit" value={t.search} className="btn btn-outline-danger w-100" datadisablewith="seach" />
				</div>
			</form>

		</section>
	)
}
export default Filter
