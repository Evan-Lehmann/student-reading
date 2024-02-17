defmodule App.Quiz do
  @moduledoc """
  The Quiz context.
  """

  import Ecto.Query, warn: false
  alias App.Repo

  alias App.Quiz.McqAnswer

  @doc """
  Returns the list of stories.

  ## Examples

      iex> list_stories()
      [%Story{}, ...]

  """

  @doc """
  Gets a single story.

  Raises `Ecto.NoResultsError` if the Story does not exist.

  ## Examples

      iex> get_story!(123)
      %Story{}

      iex> get_story!(456)
      ** (Ecto.NoResultsError)

  """

  @doc """
  Creates a story.

  ## Examples

      iex> create_story(%{field: value})
      {:ok, %Story{}}

      iex> create_story(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  @doc """
  Updates a story.

  ## Examples

      iex> update_story(story, %{field: new_value})
      {:ok, %Story{}}

      iex> update_story(story, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """


  @doc """
  Deletes a story.

  ## Examples

      iex> delete_story(story)
      {:ok, %Story{}}

      iex> delete_story(story)
      {:error, %Ecto.Changeset{}}

  """

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking story changes.

  ## Examples

      iex> change_story(story)
      %Ecto.Changeset{data: %Story{}}

  """


  @doc """
  Returns the list of questions.

  ## Examples

      iex> list_questions()
      [%Question{}, ...]

  """


  @doc """
  Gets a single question.

  Raises `Ecto.NoResultsError` if the Question does not exist.

  ## Examples

      iex> get_question!(123)
      %Question{}

      iex> get_question!(456)
      ** (Ecto.NoResultsError)

  """

  @doc """
  Creates a question.

  ## Examples

      iex> create_question(%{field: value})
      {:ok, %Question{}}

      iex> create_question(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """


  @doc """
  Updates a question.

  ## Examples

      iex> update_question(question, %{field: new_value})
      {:ok, %Question{}}

      iex> update_question(question, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  def get_answers_of_mcq(mcq_id) do
    from(m in McqAnswer, where: m.mcq_id == ^mcq_id)
    |> Repo.all()
    |> Repo.preload(:mcq)
  end

  def is_mcq_answer_correct(id) do
    from(m in McqAnswer, where: m.id == ^id, select: m.is_correct)
    |> Repo.one()
  end

  @doc """
  Deletes a question.

  ## Examples

      iex> delete_question(question)
      {:ok, %Question{}}

      iex> delete_question(question)
      {:error, %Ecto.Changeset{}}

  """


  @doc """
  Returns an `%Ecto.Changeset{}` for tracking question changes.

  ## Examples

      iex> change_question(question)
      %Ecto.Changeset{data: %Question{}}

  """


  @doc """
  Returns the list of answers.

  ## Examples

      iex> list_answers()
      [%Answer{}, ...]

  """


  @doc """
  Gets a single answer.

  Raises `Ecto.NoResultsError` if the Answer does not exist.

  ## Examples

      iex> get_answer!(123)
      %Answer{}

      iex> get_answer!(456)
      ** (Ecto.NoResultsError)

  """

  @doc """
  Creates a answer.

  ## Examples

      iex> create_answer(%{field: value})
      {:ok, %Answer{}}

      iex> create_answer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  @doc """
  Updates a answer.

  ## Examples

      iex> update_answer(answer, %{field: new_value})
      {:ok, %Answer{}}

      iex> update_answer(answer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  @doc """
  Deletes a answer.

  ## Examples

      iex> delete_answer(answer)
      {:ok, %Answer{}}

      iex> delete_answer(answer)
      {:error, %Ecto.Changeset{}}

  """

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking answer changes.

  ## Examples

      iex> change_answer(answer)
      %Ecto.Changeset{data: %Answer{}}

  """



  @doc """
  Returns the list of completed_stories.

  ## Examples

      iex> list_completed_stories()
      [%CompletedStory{}, ...]

  """


  @doc """
  Gets a single completed_story.

  Raises `Ecto.NoResultsError` if the Completed story does not exist.

  ## Examples

      iex> get_completed_story!(123)
      %CompletedStory{}

      iex> get_completed_story!(456)
      ** (Ecto.NoResultsError)

  """

  @doc """
  Creates a completed_story.

  ## Examples

      iex> create_completed_story(%{field: value})
      {:ok, %CompletedStory{}}

      iex> create_completed_story(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  @doc """
  Updates a completed_story.

  ## Examples

      iex> update_completed_story(completed_story, %{field: new_value})
      {:ok, %CompletedStory{}}

      iex> update_completed_story(completed_story, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """




  @doc """
  Deletes a completed_story.

  ## Examples

      iex> delete_completed_story(completed_story)
      {:ok, %CompletedStory{}}

      iex> delete_completed_story(completed_story)
      {:error, %Ecto.Changeset{}}

  """


  @doc """
  Returns an `%Ecto.Changeset{}` for tracking completed_story changes.

  ## Examples

      iex> change_completed_story(completed_story)
      %Ecto.Changeset{data: %CompletedStory{}}

  """

  alias App.Quiz.Mcq

  def get_mcq_by_difficulty_and_last_word(difficulty, last_word) do
    mcqs= from(m in Mcq, where: m.difficulty == ^difficulty and m.word != ^last_word)
    |> Repo.all()

    mcq = Enum.random(mcqs)
    %{"word" => mcq.word, "hint" => mcq.hint}
  end

  def get_inc_words(correct_word) do
    inc_words = from(m in McqAnswer, where: m.word != ^correct_word, select: m.word)
    |> Repo.all()

    Enum.take_random(inc_words, 3)
  end

  def get_inc_words(correct_word, hint) do
    inc_words = from(m in McqAnswer, where: m.word != ^correct_word and m.hint != ^hint, select: m.word)
    |> Repo.all()

    Enum.take_random(inc_words, 3)
  end

  def get_mcq_by_difficulty(difficulty) do
    mcqs= from(m in Mcq, where: m.difficulty == ^difficulty)
    |> Repo.all()

    mcq = Enum.random(mcqs)
    %{"word" => mcq.word, "hint" => mcq.hint}
  end

  def get_hint_by_word(word) do
    selected_hint = Repo.one(from u in McqAnswer,
      where: u.word == ^word,
      select: u.hint)

    if is_nil(selected_hint) do
        word
    else
        selected_hint
    end
  end

  @doc """
  Returns the list of mcqs.

  ## Examples

      iex> list_mcqs()
      [%Mcq{}, ...]

  """
  def list_mcqs do
    Repo.all(Mcq)
  end


  @doc """
  Gets a single mcq.

  Raises `Ecto.NoResultsError` if the Mcq does not exist.

  ## Examples

      iex> get_mcq!(123)
      %Mcq{}

      iex> get_mcq!(456)
      ** (Ecto.NoResultsError)

  """
  def get_mcq!(id), do: Repo.get!(Mcq, id)

  @doc """
  Creates a mcq.

  ## Examples

      iex> create_mcq(%{field: value})
      {:ok, %Mcq{}}

      iex> create_mcq(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_mcq(attrs \\ %{}) do
    %Mcq{}
    |> Mcq.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a mcq.

  ## Examples

      iex> update_mcq(mcq, %{field: new_value})
      {:ok, %Mcq{}}

      iex> update_mcq(mcq, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_mcq(%Mcq{} = mcq, attrs) do
    mcq
    |> Mcq.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a mcq.

  ## Examples

      iex> delete_mcq(mcq)
      {:ok, %Mcq{}}

      iex> delete_mcq(mcq)
      {:error, %Ecto.Changeset{}}

  """
  def delete_mcq(%Mcq{} = mcq) do
    Repo.delete(mcq)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking mcq changes.

  ## Examples

      iex> change_mcq(mcq)
      %Ecto.Changeset{data: %Mcq{}}

  """
  def change_mcq(%Mcq{} = mcq, attrs \\ %{}) do
    Mcq.changeset(mcq, attrs)
  end

  alias App.Quiz.McqAnswer

  @doc """
  Returns the list of mcqs_answers.

  ## Examples

      iex> list_mcqs_answers()
      [%McqAnswer{}, ...]

  """
  def list_mcqs_answers do
    Repo.all(McqAnswer)
  end

  @doc """
  Gets a single mcq_answer.

  Raises `Ecto.NoResultsError` if the Mcq answer does not exist.

  ## Examples

      iex> get_mcq_answer!(123)
      %McqAnswer{}

      iex> get_mcq_answer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_mcq_answer!(id), do: Repo.get!(McqAnswer, id)

  @doc """
  Creates a mcq_answer.

  ## Examples

      iex> create_mcq_answer(%{field: value})
      {:ok, %McqAnswer{}}

      iex> create_mcq_answer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_mcq_answer(attrs \\ %{}) do
    %McqAnswer{}
    |> McqAnswer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a mcq_answer.

  ## Examples

      iex> update_mcq_answer(mcq_answer, %{field: new_value})
      {:ok, %McqAnswer{}}

      iex> update_mcq_answer(mcq_answer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_mcq_answer(%McqAnswer{} = mcq_answer, attrs) do
    mcq_answer
    |> McqAnswer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a mcq_answer.

  ## Examples

      iex> delete_mcq_answer(mcq_answer)
      {:ok, %McqAnswer{}}

      iex> delete_mcq_answer(mcq_answer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_mcq_answer(%McqAnswer{} = mcq_answer) do
    Repo.delete(mcq_answer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking mcq_answer changes.

  ## Examples

      iex> change_mcq_answer(mcq_answer)
      %Ecto.Changeset{data: %McqAnswer{}}

  """
  def change_mcq_answer(%McqAnswer{} = mcq_answer, attrs \\ %{}) do
    McqAnswer.changeset(mcq_answer, attrs)
  end
end
