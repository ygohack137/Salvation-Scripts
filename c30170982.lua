--死のメッセージ「H」
function c30170982.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_SSET)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SPSUMMON_COST)
	e2:SetCost(c30170982.spcost)
	c:RegisterEffect(e2)
end
function c30170982.spcost(e,c,tp,sumtype)
	return sumtype==SUMMON_TYPE_SPECIAL+181
end